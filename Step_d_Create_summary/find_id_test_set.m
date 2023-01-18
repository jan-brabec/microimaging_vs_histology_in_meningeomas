function test_ind = find_id_test_set(I_measured,measured,I_pred,predicted,ROI)
% function ind = find_id_test_set(I_MD_measured,measured,I_MD_pred,predicted)
%
%   Returns indices of test set back computed


id = [];
for i = 1:numel(measured)
    
    idm = find(I_measured == measured(i));
    idp = find(I_pred == predicted(i));
    
    try
        if any(idm ~= idp)
            id(i) = intersect(idp,idm);
        elseif all(idm == idp)
            id(i) = idm;
        end
        
    catch
        
        tmpi = intersect(idp,idm);
        roi = find(ROI == 1);
        tmp = intersect(tmpi,roi);

        if isempty(tmp)
            id(i) = tmpi(1);
        else
            id(i) = tmp(1);
        end
        
    end
    
    if numel(id(i)) > 1
        id = id(randi(numel(id),1,1));
        error('too many elements')
    end
    
    if isempty(id(i))
        error('empty')
    end
    
end

test_ind = zeros(size(I_measured));
test_ind(id) = 1;

