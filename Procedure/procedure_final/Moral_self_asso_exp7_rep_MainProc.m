function Moral_self_asso_exp7_rep_MainProc
%%
% History: Based on my previous stuy; 
% 
% Date         Author          Notes for change
% =========================================================================
% 17/12/2017   hcp4715         Start to modifying the code
%
% =========================================================================
% Aim: Replicate my Experiment 7 of moral association, which dedicated for
% categorization task.
%
% This is the main m file for the experiment, which refer to the following
% scripts:
% 1. Moral_self_asso_exp7_rep_subinfo_vf.m
% 2. Moral_self_asso_exp7_rep_getParams.m
% 3. Moral_self_asso_exp7_rep_match
% 4. Moral_self_asso_exp7_rep_categ

% Experimental design for the categorization task: 
% 2 (id: self vs. other) * 3 (moral valence: postive, neutral, vs. negative) *
% 2 categorization task(tasks type: morality, self)

% Input variables:
% subjects' ID, age, sex, and condition;

% This experiment was aimed to replicate my previous studies, so that 
% we can confirm our resulting patter. In this exp., we also have two phases:
% First, Learning phase, in which participant making match judgmnet;
% Second,Categorization phase, judge the category of stimuli according to
% criteria.
% 
% Differences from exp7:
% Items          replication    original
% =============  =============  ==========
% Moral valence  three levels    two levels
% Categ. task    two tasks       three tasks
% feedback       words           schema faces

%% details about trials
% trials for matching task
% 500ms(fixation) + 100ms(target display) + blank(800-1100ms) +
% 500ms(feedabkc)
% one trial: 2,200ms

% trials for categorization task: 
% Fixation: 500ms + target display: 200ms + blank: 800-1200ms, No feedback

% One trial: 1500-2100ms

% Stimuli: 
% 6 shapes in this Exp: 2( identity: self vs. other)*2( moral valence: positive, neutral vs. negative);

% Moral Self(MS),   Neutral Self (NS),  Immoral Self (IS); 
% Moral Other (MO), Neutral Other (NN), Immoral Other (IO);

% Six labels in this Exp.;
% "好我","常我","坏我";"好人","常人","坏人"

% Task：Categorization, Whether the shape presented belongs to one categories?

% Total block: 8, number of trials in each block: 24*6

% Data is collected in the file: Exp_behav_moral_asso_exp7_rep_(subID).out
 
% vairables:
% params    --  globale variable, get parameters from getParams.m
%

%% 清屏 清空内存
clear; close all;
startT = GetSecs;
%% 输入被试信息

[subID, age, gender, handness] = Moral_self_asso_exp7_rep_subinfo;
addpath(pwd);

%% 添加全局变量
global params    % get all parameters from in params

%% 设置窗口参数
% Chose skip ScreenTest or not
Screen('Preference','SkipSyncTests',2);
AssertOpenGL;
 
% [windowPtr,rect] = Screen('OpenWindow',params.whichscreen,params.gray);
% Screen('BlendFunction',windowPtr,GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA); % part of Alpha function, would be used for ramp up the contrast
HideCursor;

%% 定义实验参数
params = Moral_self_asso_exp7_getParams(subID); % mind the trials per condition in params file!

%% ******** practicing **********
initNumBlock = 1;  % !!!! change to 1 before real experiment
initNumBin = 2;    % !!!! change to 2 before real experiment
Moral_self_asso_exp7_match(subID,gender,age,handness,initNumBlock,initNumBin);


%% ********* Learning phrase **************
% study two blocks at the beginning
initNumBlock = 2;  % !!! change to 2 before real experiment
initNumBin = 5;    % !!! change to 5 before real experiment
Moral_self_asso_exp7_match(subID,gender,age,handness,initNumBlock,initNumBin);
 
%% ******** Categrozation phrase *************
for block = 1:6     %  6 blocks
    task = cell2mat(params.taskMatrix{block});
    numBinTest = 6;   % !!!!change to 6 before real experiment
    numBinLearn = 2;  % !!!!chanage to 2 before real experiment
    Moral_self_asso_exp7_categ(subID,gender,age,handness,task,block,numBinTest);
%     if block == 3  % re-study the association task per 3 blocks of categorization
    if block < 6
        Moral_self_asso_exp7_match(subID,gender,age,handness,1,numBinLearn) 
    end

end
Screen('CloseAll')
ShowCursor
Priority(0);
endT = GetSecs;
fprintf('the duraiton of whole experiment: %f \n',endT - startT);

return 
