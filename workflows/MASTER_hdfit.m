%%
clear all; clear global; pack
addpath('D:\My_Documents\GitHub\hdmodelfit\shared');
%addpath('C:\Users\mvdm\Documents\GitHub\hdmodelfit\shared'); % isidro

cd('D:\My_Documents\Dropbox\projects\HDfit\data');

%% test
global param; % to access internals of crossval();
global param_count;
param_count = 0;

out = hdfit_crossval_func([]);

%% multirun

clear ALL_out;

sessions_to_run = [1 2 3 10];% 11 12];
targets_to_run = {'std','laser'};
filters_to_run = {'smooth','kalman','kalmanwrapped'};

for iS = length(sessions_to_run):-1:1
    for iT = 1:length(targets_to_run)
        for iF = 1:length(filters_to_run)

            this_cfg = [];
            this_cfg.session = sessions_to_run(iS);
            this_cfg.target_session = targets_to_run{iT};
            this_cfg.mode = filters_to_run{iF};
            
            this_out = hdfit_crossval_func(this_cfg);
            
            ALL_out(iS).(targets_to_run{iT}).(filters_to_run{iF}) = this_out;
        end
    end
end

   