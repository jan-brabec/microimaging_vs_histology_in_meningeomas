function [lims_dir_FA2D, lims_dir_IA] = get_dir_lims(sample,c)
% function [lims_dir_MR, lims_dir_H] = get_dir_lims(sample,c)
%
% Return limits for plotting of difrection FA.

switch sample
    case 1
        lims_dir_IA  = c;
        lims_dir_FA2D = 1.3 * lims_dir_IA;
        
    case 2
        lims_dir_IA  = c;
        lims_dir_FA2D = 0.9 * lims_dir_IA;    
        
    case 3
        lims_dir_IA  = c;
        lims_dir_FA2D = 0.6 * lims_dir_IA;          
        
    case 4
        lims_dir_IA  = c;
        lims_dir_FA2D = 1.2 * lims_dir_IA;          
        
    case 5
        lims_dir_IA  = c;
        lims_dir_FA2D = 1.2 * lims_dir_IA;    
        
    case 6
        lims_dir_IA  = c;
        lims_dir_FA2D = 1.3 * lims_dir_IA;          
        
    case 7
        lims_dir_IA  = c;
        lims_dir_FA2D = 0.9 * lims_dir_IA;     
        
    case 8
        lims_dir_IA  = c;
        lims_dir_FA2D = 1.4 * lims_dir_IA;     
        
    case 9
        lims_dir_IA  = c;
        lims_dir_FA2D = 1.3 * lims_dir_IA;     %%     
         
    case 10
        lims_dir_IA  = c;
        lims_dir_FA2D = 1.0 * lims_dir_IA;      
        
    case 11
        lims_dir_IA  = c;
        lims_dir_FA2D = 1.1 * lims_dir_IA;          
        
    case 12
        lims_dir_IA  = c;
        lims_dir_FA2D = 1.1 * lims_dir_IA;         
        
    case 13
        lims_dir_IA  = c;
        lims_dir_FA2D = 1.3 * lims_dir_IA;       
        
    case 14
        lims_dir_IA  = c;
        lims_dir_FA2D = 0.7 * lims_dir_IA;          
        
    case 15
        lims_dir_IA  = c;
        lims_dir_FA2D = 1.4 * lims_dir_IA;           
        
    case 16
        lims_dir_IA  = c;
        lims_dir_FA2D = 1.3 * lims_dir_IA;               
                
        
end

end