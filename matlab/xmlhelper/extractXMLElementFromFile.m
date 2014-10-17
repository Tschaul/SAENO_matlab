function theStruct=extractXMLElementFromFile(fname,elementname)

fid = fopen(fname);

tline = fgetl(fid);

elementString=[];

while ischar(tline)
        
    %disp(tline)
    
    k = strfind(tline, [ '<' elementname ]);
    
    if numel(k)>0
        
        elementString=[elementString tline(k:end)];
        
        tline = fgetl(fid);
        
        break
        
    end
    tline = fgetl(fid);
    
    
end

while ischar(tline)
        
    k = strfind(tline, [ '</' elementname '>']);
    
    if numel(k)>0
        
        elementString=[elementString tline(1:(k+numel([ '</' elementname '>'])-1))];
        
        tline = fgetl(fid);
        
        break
        
    else
        
        elementString=[elementString tline];
        
        
    end
    
    tline = fgetl(fid);
    
end

fclose(fid);

tree = xmlreadstring(elementString);

theStruct=parseChildNodes(tree);



% ----- Local function PARSECHILDNODES -----
function children = parseChildNodes(theNode)
% Recurse over node children.
children = [];
if theNode.hasChildNodes
   childNodes = theNode.getChildNodes;
   numChildNodes = childNodes.getLength;
   allocCell = cell(1, numChildNodes);

   children = struct(             ...
      'Name', allocCell, 'Attributes', allocCell,    ...
      'Data', allocCell, 'Children', allocCell);

    for count = 1:numChildNodes
        theChild = childNodes.item(count-1);
        children(count) = makeStructFromNode(theChild);
    end
end

% ----- Local function MAKESTRUCTFROMNODE -----
function nodeStruct = makeStructFromNode(theNode)
% Create structure of node info.

nodeStruct = struct(                        ...
   'Name', char(theNode.getNodeName),       ...
   'Attributes', parseAttributes(theNode),  ...
   'Data', '',                              ...
   'Children', parseChildNodes(theNode));

if any(strcmp(methods(theNode), 'getData'))
   nodeStruct.Data = char(theNode.getData); 
else
   nodeStruct.Data = '';
end

% ----- Local function PARSEATTRIBUTES -----
function attributes = parseAttributes(theNode)
% Create attributes structure.

attributes = [];
if theNode.hasAttributes
   theAttributes = theNode.getAttributes;
   numAttributes = theAttributes.getLength;
   allocCell = cell(1, numAttributes);
   attributes = struct('Name', allocCell, 'Value', ...
                       allocCell);

   for count = 1:numAttributes
      attrib = theAttributes.item(count-1);
      attributes(count).Name = char(attrib.getName);
      attributes(count).Value = char(attrib.getValue);
   end
end


