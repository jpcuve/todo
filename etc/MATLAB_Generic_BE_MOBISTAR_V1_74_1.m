function varargout = MATLAB_Generic_BE_Proximus_V2_0(varargin)
% MATLAB_Generic_BE_Proximus_V2_0 M-file for beta_rating_mobistar_cdr_with_split_bill_option.fig
%      MATLAB_Generic_BE_Proximus_V2_0, by itself, creates a new BETA_RATING_MOBISTAR_CDR_WITH_SPLIT_BILL_OPTION or raises the existing
%      singleton* .
%
%      H = MATLAB_Generic_BE_Proximus_V2_0 returns the handle to a new BETA_RATING_MOBISTAR_CDR_WITH_SPLIT_BILL_OPTION or the handle to
%      the existing singleton*.
%
%      MATLAB_Generic_BE_Proximus_V2_0('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BETA_RATING_MOBISTAR_CDR_WITH_SPLIT_BILL_OPTION.M with the given input arguments.
%
%      MATLAB_Generic_BE_Proximus_V2_0('Property','Value',...) creates a new BETA_RATING_MOBISTAR_CDR_WITH_SPLIT_BILL_OPTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beta_rating_mobistar_cdr_with_split_bill_option_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beta_rating_mobistar_cdr_with_split_bill_option_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help beta_rating_mobistar_cdr_with_split_bill_option

% Last Modified by GUIDE v2.5 13-Oct-2014 16:23:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MATLAB_Generic_BE_Proximus_V2_0_OpeningFcn, ...
                   'gui_OutputFcn',  @MATLAB_Generic_BE_Proximus_V2_0_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before beta_rating_mobistar_cdr_with_split_bill_option is made visible.
function MATLAB_Generic_BE_Proximus_V2_0_OpeningFcn(hObject, eventdata, handles, varargin)
global Client_ID

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beta_rating_mobistar_cdr_with_split_bill_option (see VARARGIN)

% Choose default command line output for beta_rating_mobistar_cdr_with_split_bill_option
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);
%[FileName,PathName] = uigetfile({'*.*','Fichier des noms de clients';'*.*','All Files' },'Fichier de Config Out');      
if exist('\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\2_Generics\B_Code\Martyr_MATLAB\code_client.txt', 'file')
   fid=fopen('\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\2_Generics\B_Code\Martyr_MATLAB\code_client.txt');
  % File exists.  Do stuff....
else
  % File does not exist.
  warningMessage = sprintf('Warning: file does not exist:\n%s', '\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\2_Generics\B_Code\Martyr_MATLAB\code_client.txt');
  msgbox(warningMessage);
  [FileName,PathName] = uigetfile({'*.*','Fichier des noms de clients';'*.*','All Files' },'Introduire manuellement ce fichier code client');  
  fid=fopen([PathName,FileName]);
end


Client_ID=textscan(fid,'%s');
max(size(Client_ID{1}(:)))
set(handles.popupmenu1,'string',Client_ID{1})

% UIWAIT makes beta_rating_mobistar_cdr_with_split_bill_option wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = MATLAB_Generic_BE_Proximus_V2_0_OutputFcn(hObject, eventdata, handles) 
global Client_Identification
global log_file_text;
global no_display_of_histogram
global no_generation_of_MUAC
if isempty(no_display_of_histogram) no_display_of_histogram=0;end
if isempty(no_generation_of_MUAC) no_generation_of_MUAC=0;end
Client_Identification={'C:\'};
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
log_file_text=[];
 warning off all
 set(handles.edit9,'String',['DEBUT EXECUTION:',datestr(now)]);
 bidonbidon=[char(10),'DEBUT EXECUTION:',datestr(now)];log_file_text=[log_file_text,bidonbidon];

% Get default command line output from handles structure
varargout{1} = handles.output;

hold on
Title(handles.axes1,'Histogram of Spending per Employee')
grid on


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global log_file_text;

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
debut_execution=datestr(now);

global compteur minute Consumption_count Amount_for_MUAC Amount_for_histogram CDR_Reconnu k l i prix prix_pour_histogramme prix_pour_MUAC
global compteur_par_Renaming minute_par_Renaming prix_par_Renaming prix
global compteur2 minute2 Consumption_count Amount_for_MUAC CDR_Reconnu k l i prix2
global compteur_par_Remapping_CYC2 minute_par_Remapping_CYC2 prix_par_Remapping_CYC2
global Client_Identification
global no_display_of_histogram
global no_generation_of_MUAC
no_display_of_histogram
no_generation_of_MUAC
log_file_text=[];
set(handles.edit9,'String',['***********************************************************************************']);log_file_text=[log_file_text,'***********************************************************************************'];
set(handles.edit9,'String',['*         PROOF OF CONCEPT - Version provisoire du 6/2/2013                       *']);log_file_text=[log_file_text,'*         PROOF OF CONCEPT - Version provisoire du 6/2/2013                       *'];
set(handles.edit9,'String',['***********************************************************************************']);log_file_text=[log_file_text,'***********************************************************************************'];

%Tu trouvais que l’histogramme devait aussi ne prendre en compte que les
%numéros pour lesquels il y a avait un Y dans la colonne Ranking du SIM Mapping.
%J’ai intégré cela dans cette version 167.
%Petite astuce : les numéros pour lesquels la valeur du ranking est N ont tout de même un histogramme dans leur individual report et on montre où leur montant de dépense se situerait dans l’histogramme si on en avait tenu compte.
%Je m’explique : on considère une flotte de 110 numéros. 50 numéros ont leur ranking mis à Y. L’individual overview de ces numéros aura un histogramme dont la somme des populations des classes fait 50 et chaque numéro est répertorié/indiqué dans l’histogramme.
%Pour les 60 autres, on imprime aussi un histogramme à 50 individus mais on met tout de même pour les 60 en question où ils viendraient dans l’histogramme si jamais ils avaient eu leur Ranking à Y.

if no_display_of_histogram==1
text(0,0.75, 'NO UPDATE OF HISTOGRAM','FontSize',18);
else
text(0,0.75, '                                      ','FontSize',18);
end

if strcmp(Client_Identification,'C:\');
     warndlg('You did not select a new customer compared to last run');
end


if strcmp(Client_Identification,'C:\');
    temp=[':\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\'];
else
    temp=['\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\',Client_Identification,'\6_Mapping\SIM\*config*.*'];
end 

[FileName,PathName] = uigetfile({'*config*.*','Fichier de configuration';'*.*','All Files' },'Fichier de Config Out',temp);      
fid=fopen([PathName,FileName]);
C=textscan(fid,'%s %s %s %s %s %s %s','delimiter',';','headerlines',1);

HIST_1_EN=[];HIST_2_EN=[];HIST_3_EN=[];HIST_4_EN=[];HIST_5_EN=[];HIST_6_EN=[];CS_1_EN=[];CS_2_EN=[];CS_3_EN=[];CS_4_EN=[];CS_5_EN=[];CS_6_EN=[];
CS_7_EN=[];CS_8_EN=[];TR_1_EN=[];TR_2_EN=[];TR_3_EN=[];TR_4_EN=[];TR_5_EN=[];TR_6_EN=[];TR_7_EN=[];TR_8_EN=[];TR_9_EN=[];TR_10_EN=[];TR_11_EN=[];TR_12_EN=[];
TR_13_EN=[];TR_14_EN=[];TR_15_EN=[];CD_1_EN=[];CD_2_EN=[];CD_3_EN=[];CD_4_EN=[];CD_5_EN=[];CD_6_EN=[];CD_7_EN=[];CD_8_EN=[];CD_9_EN=[];
HIST_1_FR=[];HIST_2_FR=[];HIST_3_FR=[];HIST_4_FR=[];HIST_5_FR=[];HIST_6_FR=[];CS_1_FR=[];CS_2_FR=[];CS_3_FR=[];CS_4_FR=[];CS_5_FR=[];CS_6_FR=[];
CS_7_FR=[];CS_8_FR=[];TR_1_FR=[];TR_2_FR=[];TR_3_FR=[];TR_4_FR=[];TR_5_FR=[];TR_6_FR=[];TR_7_FR=[];TR_8_FR=[];TR_9_FR=[];TR_10_FR=[];TR_11_FR=[];TR_12_FR=[];
TR_13_FR=[];TR_14_FR=[];TR_15_FR=[];CD_1_FR=[];CD_2_FR=[];CD_3_FR=[];CD_4_FR=[];CD_5_FR=[];CD_6_FR=[];CD_7_FR=[];CD_8_FR=[];CD_9_FR=[];
HIST_1_NL=[];HIST_2_NL=[];HIST_3_NL=[];HIST_4_NL=[];HIST_5_NL=[];HIST_6_NL=[];CS_1_NL=[];CS_2_NL=[];CS_3_NL=[];CS_4_NL=[];CS_5_NL=[];CS_6_NL=[];
CS_7_NL=[];CS_8_NL=[];TR_1_NL=[];TR_2_NL=[];TR_3_NL=[];TR_4_NL=[];TR_5_NL=[];TR_6_NL=[];TR_7_NL=[];TR_8_NL=[];TR_9_NL=[];TR_10_NL=[];TR_11_NL=[];TR_12_NL=[];
TR_13_NL=[];TR_14_NL=[];TR_15_NL=[];CD_1_NL=[];CD_2_NL=[];CD_3_NL=[];CD_4_NL=[];CD_5_NL=[];CD_6_NL=[];CD_7_NL=[];CD_8_NL=[];CD_9_NL=[];
HIST_1_GE=[];HIST_2_GE=[];HIST_3_GE=[];HIST_4_GE=[];HIST_5_GE=[];HIST_6_GE=[];CS_1_GE=[];CS_2_GE=[];CS_3_GE=[];CS_4_GE=[];CS_5_GE=[];CS_6_GE=[];
CS_7_GE=[];CS_8_GE=[];TR_1_GE=[];TR_2_GE=[];TR_3_GE=[];TR_4_GE=[];TR_5_GE=[];TR_6_GE=[];TR_7_GE=[];TR_8_GE=[];TR_9_GE=[];TR_10_GE=[];TR_11_GE=[];TR_12_GE=[];
TR_13_GE=[];TR_14_GE=[];TR_15_GE=[];CD_1_GE=[];CD_2_GE=[];CD_3_GE=[];CD_4_GE=[];CD_5_GE=[];CD_6_GE=[];CD_7_GE=[];CD_8_GE=[];CD_9_GE=[];
HIST_1_IT=[];HIST_2_IT=[];HIST_3_IT=[];HIST_4_IT=[];HIST_5_IT=[];HIST_6_IT=[];CS_1_IT=[];CS_2_IT=[];CS_3_IT=[];CS_4_IT=[];CS_5_IT=[];CS_6_IT=[];
CS_7_IT=[];CS_8_IT=[];TR_1_IT=[];TR_2_IT=[];TR_3_IT=[];TR_4_IT=[];TR_5_IT=[];TR_6_IT=[];TR_7_IT=[];TR_8_IT=[];TR_9_IT=[];TR_10_IT=[];TR_11_IT=[];TR_12_IT=[];
TR_13_IT=[];TR_14_IT=[];TR_15_IT=[];CD_1_IT=[];CD_2_IT=[];CD_3_IT=[];CD_4_IT=[];CD_5_IT=[];CD_6_IT=[];CD_7_IT=[];CD_8_IT=[];CD_9_IT=[];

TR_4_NEUTRE=[];TR_5_NEUTRE=[];TR_6_NEUTRE=[];TR_7_NEUTRE=[];TR_8_NEUTRE=[]; % version 1.7
TR_9_NEUTRE=[];TR_10_NEUTRE=[];TR_11_NEUTRE=[];TR_12_NEUTRE=[];TR_13_NEUTRE=[]; % version 1.7
TR_4_NEUTRE=[TR_4_NEUTRE; C{1}(18)]; % version 1.7
TR_5_NEUTRE=[TR_5_NEUTRE;C{1}(19)]; % version 1.7
TR_6_NEUTRE=[TR_6_NEUTRE; C{1}(20)]; % version 1.7
TR_7_NEUTRE=[TR_7_NEUTRE; C{1}(21)]; % version 1.7
TR_8_NEUTRE=[TR_8_NEUTRE; C{1}(22)]; % version 1.7
TR_9_NEUTRE=[TR_9_NEUTRE; C{1}(23)]; % version 1.7
TR_10_NEUTRE=[TR_10_NEUTRE; C{1}(24)]; % version 1.7
TR_11_NEUTRE=[TR_11_NEUTRE; C{1}(25)]; % version 1.7
TR_12_NEUTRE=[TR_12_NEUTRE; C{1}(26)]; % version 1.7
TR_13_NEUTRE=[TR_13_NEUTRE; C{1}(27)]; % version 1.7


HIST_1_EN=[HIST_1_EN;C{3}(1)];
HIST_2_EN=[HIST_2_EN; C{3}(2)];
HIST_3_EN=[HIST_3_EN; C{3}(3)];
HIST_4_EN=[HIST_4_EN; C{3}(4)];
HIST_5_EN=[HIST_5_EN; C{3}(5)];
HIST_6_EN=[HIST_6_EN; C{3}(6)];
CS_1_EN=[CS_1_EN; C{3}(7)];
CS_2_EN=[CS_2_EN; C{3}(8)];
CS_3_EN=[CS_3_EN; C{3}(9)];
CS_4_EN=[CS_4_EN; C{3}(10)];
CS_5_EN=[CS_5_EN; C{3}(11)];
CS_6_EN=[CS_6_EN; C{3}(12)];
CS_7_EN=[CS_7_EN; C{3}(13)];
CS_8_EN=[CS_8_EN; C{3}(14)];
TR_1_EN=[TR_1_EN; C{3}(15)];
TR_2_EN=[TR_2_EN; C{3}(16)];
TR_3_EN=[TR_3_EN; C{3}(17)];
TR_4_EN=[TR_4_EN; C{3}(18)];
TR_5_EN=[TR_5_EN;C{3}(19)];
TR_6_EN=[TR_6_EN; C{3}(20)];
TR_7_EN=[TR_7_EN; C{3}(21)];
TR_8_EN=[TR_8_EN; C{3}(22)];
TR_9_EN=[TR_9_EN; C{3}(23)];
TR_10_EN=[TR_10_EN; C{3}(24)];
TR_11_EN=[TR_11_EN; C{3}(25)];
TR_12_EN=[TR_12_EN; C{3}(26)];
TR_13_EN=[TR_13_EN; C{3}(27)];
TR_14_EN=[TR_14_EN; C{3}(28)];
TR_15_EN=[TR_15_EN; C{3}(29)];
CD_1_EN=[CD_1_EN; C{3}(30)];
CD_2_EN=[CD_2_EN; C{3}(31)];
CD_3_EN=[CD_3_EN; C{3}(32)];
CD_4_EN=[CD_4_EN; C{3}(33)];
CD_5_EN=[CD_5_EN; C{3}(34)];
CD_6_EN=[CD_6_EN; C{3}(35)];
CD_7_EN=[CD_7_EN; C{3}(36)];
CD_8_EN=[CD_8_EN; C{3}(37)];
CD_9_EN=[CD_9_EN; C{3}(38)];
 
HIST_1_FR=[HIST_1_FR;C{4}(1)];
HIST_2_FR=[HIST_2_FR; C{4}(2)];
HIST_3_FR=[HIST_3_FR; C{4}(3)];
HIST_4_FR=[HIST_4_FR; C{4}(4)];
HIST_5_FR=[HIST_5_FR; C{4}(5)];
HIST_6_FR=[HIST_6_FR; C{4}(6)];
CS_1_FR=[CS_1_FR; C{4}(7)];
CS_2_FR=[CS_2_FR; C{4}(8)];
CS_3_FR=[CS_3_FR; C{4}(9)];
CS_4_FR=[CS_4_FR; C{4}(10)];
CS_5_FR=[CS_5_FR; C{4}(11)];
CS_6_FR=[CS_6_FR; C{4}(12)];
CS_7_FR=[CS_7_FR; C{4}(13)];
CS_8_FR=[CS_8_FR; C{4}(14)];
TR_1_FR=[TR_1_FR; C{4}(15)];
TR_2_FR=[TR_2_FR; C{4}(16)];
TR_3_FR=[TR_3_FR; C{4}(17)];
TR_4_FR=[TR_4_FR; C{4}(18)];
TR_5_FR=[TR_5_FR;C{4}(19)];
TR_6_FR=[TR_6_FR; C{4}(20)];
TR_7_FR=[TR_7_FR; C{4}(21)];
TR_8_FR=[TR_8_FR; C{4}(22)];
TR_9_FR=[TR_9_FR; C{4}(23)];
TR_10_FR=[TR_10_FR; C{4}(24)];
TR_11_FR=[TR_11_FR; C{4}(25)];
TR_12_FR=[TR_12_FR; C{4}(26)];
TR_13_FR=[TR_13_FR; C{4}(27)];
TR_14_FR=[TR_14_FR; C{4}(28)];
TR_15_FR=[TR_15_FR; C{4}(29)];
CD_1_FR=[CD_1_FR; C{4}(30)];
CD_2_FR=[CD_2_FR; C{4}(31)];
CD_3_FR=[CD_3_FR; C{4}(32)];
CD_4_FR=[CD_4_FR; C{4}(33)];
CD_5_FR=[CD_5_FR; C{4}(34)];
CD_6_FR=[CD_6_FR; C{4}(35)];
CD_7_FR=[CD_7_FR; C{4}(36)];
CD_8_FR=[CD_8_FR; C{4}(37)];
CD_9_FR=[CD_9_FR; C{4}(38)];

 
HIST_1_NL=[HIST_1_NL;C{5}(1)];
HIST_2_NL=[HIST_2_NL; C{5}(2)];
HIST_3_NL=[HIST_3_NL; C{5}(3)];
HIST_4_NL=[HIST_4_NL; C{5}(4)];
HIST_5_NL=[HIST_5_NL; C{5}(5)];
HIST_6_NL=[HIST_6_NL; C{5}(6)];
CS_1_NL=[CS_1_NL; C{5}(7)];
CS_2_NL=[CS_2_NL; C{5}(8)];
CS_3_NL=[CS_3_NL; C{5}(9)];
CS_4_NL=[CS_4_NL; C{5}(10)];
CS_5_NL=[CS_5_NL; C{5}(11)];
CS_6_NL=[CS_6_NL; C{5}(12)];
CS_7_NL=[CS_7_NL; C{5}(13)];
CS_8_NL=[CS_8_NL; C{5}(14)];
TR_1_NL=[TR_1_NL; C{5}(15)];
TR_2_NL=[TR_2_NL; C{5}(16)];
TR_3_NL=[TR_3_NL; C{5}(17)];
TR_4_NL=[TR_4_NL; C{5}(18)];
TR_5_NL=[TR_5_NL;C{5}(19)];
TR_6_NL=[TR_6_NL; C{5}(20)];
TR_7_NL=[TR_7_NL; C{5}(21)];
TR_8_NL=[TR_8_NL; C{5}(22)];
TR_9_NL=[TR_9_NL; C{5}(23)];
TR_10_NL=[TR_10_NL; C{5}(24)];
TR_11_NL=[TR_11_NL; C{5}(25)];
TR_12_NL=[TR_12_NL; C{5}(26)];
TR_13_NL=[TR_13_NL; C{5}(27)];
TR_14_NL=[TR_14_NL; C{5}(28)];
TR_15_NL=[TR_15_NL; C{5}(29)];
CD_1_NL=[CD_1_NL; C{5}(30)];
CD_2_NL=[CD_2_NL; C{5}(31)];
CD_3_NL=[CD_3_NL; C{5}(32)];
CD_4_NL=[CD_4_NL; C{5}(33)];
CD_5_NL=[CD_5_NL; C{5}(34)];
CD_6_NL=[CD_6_NL; C{5}(35)];
CD_7_NL=[CD_7_NL; C{5}(36)];
CD_8_NL=[CD_8_NL; C{5}(37)];
CD_9_NL=[CD_9_NL; C{5}(38)];

 
HIST_1_IT=[HIST_1_IT;C{6}(1)];
HIST_2_IT=[HIST_2_IT; C{6}(2)];
HIST_3_IT=[HIST_3_IT; C{6}(3)];
HIST_4_IT=[HIST_4_IT; C{6}(4)];
HIST_5_IT=[HIST_5_IT; C{6}(5)];
HIST_6_IT=[HIST_6_IT; C{6}(6)];
CS_1_IT=[CS_1_IT; C{6}(7)];
CS_2_IT=[CS_2_IT; C{6}(8)];
CS_3_IT=[CS_3_IT; C{6}(9)];
CS_4_IT=[CS_4_IT; C{6}(10)];
CS_5_IT=[CS_5_IT; C{6}(11)];
CS_6_IT=[CS_6_IT; C{6}(12)];
CS_7_IT=[CS_7_IT; C{6}(13)];
CS_8_IT=[CS_8_IT; C{6}(14)];
TR_1_IT=[TR_1_IT; C{6}(15)];
TR_2_IT=[TR_2_IT; C{6}(16)];
TR_3_IT=[TR_3_IT; C{6}(17)];
TR_4_IT=[TR_4_IT; C{6}(18)];
TR_5_IT=[TR_5_IT;C{6}(19)];
TR_6_IT=[TR_6_IT; C{6}(20)];
TR_7_IT=[TR_7_IT; C{6}(21)];
TR_8_IT=[TR_8_IT; C{6}(22)];
TR_9_IT=[TR_9_IT; C{6}(23)];
TR_10_IT=[TR_10_IT; C{6}(24)];
TR_11_IT=[TR_11_IT; C{6}(25)];
TR_12_IT=[TR_12_IT; C{6}(26)];
TR_13_IT=[TR_13_IT; C{6}(27)];
TR_14_IT=[TR_14_IT; C{6}(28)];
TR_15_IT=[TR_15_IT; C{6}(29)];
CD_1_IT=[CD_1_IT; C{6}(30)];
CD_2_IT=[CD_2_IT; C{6}(31)];
CD_3_IT=[CD_3_IT; C{6}(32)];
CD_4_IT=[CD_4_IT; C{6}(33)];
CD_5_IT=[CD_5_IT; C{6}(34)];
CD_6_IT=[CD_6_IT; C{6}(35)];
CD_7_IT=[CD_7_IT; C{6}(36)];
CD_8_IT=[CD_8_IT; C{6}(37)];
CD_9_IT=[CD_9_IT; C{6}(38)];

 
HIST_1_GE=[HIST_1_GE;C{7}(1)];
HIST_2_GE=[HIST_2_GE; C{7}(2)];
HIST_3_GE=[HIST_3_GE; C{7}(3)];
HIST_4_GE=[HIST_4_GE; C{7}(4)];
HIST_5_GE=[HIST_5_GE; C{7}(5)];
HIST_6_GE=[HIST_6_GE; C{7}(6)];
CS_1_GE=[CS_1_GE; C{7}(7)];
CS_2_GE=[CS_2_GE; C{7}(8)];
CS_3_GE=[CS_3_GE; C{7}(9)];
CS_4_GE=[CS_4_GE; C{7}(10)];
CS_5_GE=[CS_5_GE; C{7}(11)];
CS_6_GE=[CS_6_GE; C{7}(12)];
CS_7_GE=[CS_7_GE; C{7}(13)];
CS_8_GE=[CS_8_GE; C{7}(14)];
TR_1_GE=[TR_1_GE; C{7}(15)];
TR_2_GE=[TR_2_GE; C{7}(16)];
TR_3_GE=[TR_3_GE; C{7}(17)];
TR_4_GE=[TR_4_GE; C{7}(18)];
TR_5_GE=[TR_5_GE;C{7}(19)];
TR_6_GE=[TR_6_GE; C{7}(20)];
TR_7_GE=[TR_7_GE; C{7}(21)];
TR_8_GE=[TR_8_GE; C{7}(22)];
TR_9_GE=[TR_9_GE; C{7}(23)];
TR_10_GE=[TR_10_GE; C{7}(24)];
TR_11_GE=[TR_11_GE; C{7}(25)];
TR_12_GE=[TR_12_GE; C{7}(26)];
TR_13_GE=[TR_13_GE; C{7}(27)];
TR_14_GE=[TR_14_GE; C{7}(28)];
TR_15_GE=[TR_15_GE; C{7}(29)];
CD_1_GE=[CD_1_GE; C{7}(30)];
CD_2_GE=[CD_2_GE; C{7}(31)];
CD_3_GE=[CD_3_GE; C{7}(32)];
CD_4_GE=[CD_4_GE; C{7}(33)];
CD_5_GE=[CD_5_GE; C{7}(34)];
CD_6_GE=[CD_6_GE; C{7}(35)];
CD_7_GE=[CD_7_GE; C{7}(36)];
CD_8_GE=[CD_8_GE; C{7}(37)];
CD_9_GE=[CD_9_GE; C{7}(38)];

fclose(fid);
clear C;

%--------------------------------------------------------------
% LECTURE DES NOMS D UTILISATEURS, dit aussi par Carlo SIM_Mapping_File
%--------------------------------------------------------------
if strcmp(Client_Identification,'C:\');
    temp=[':\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\'];
else
    temp=['\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\',Client_Identification,'\6_Mapping\SIM\*line*.*'];
end
[FileName,PathName] = uigetfile({'*line*.*','Fichier de configuration';'*.*','All Files' },'Fichier de Line Info',temp);


[GSM_Number_Mapping_GSM_Email,...
 Identification_1_Mapping_GSM_Email,...
 Identification_2_Mapping_GSM_Email,...
 Device_Type_Mapping_GSM_Email,...
 Own_Device_Mapping_GSM_Email,...
 MUAC_Mapping_GSM_Email,...
 Ranking_Mapping_GSM_Email,...
 Language_Mapping_GSM_Email,...
 EMAIL_for_the_MUAC_Mapping_GSM_Email,...
 Reserved1_Mapping_GSM_Email,...
 Reserved2_Mapping_GSM_Email,...
 Company_Mapping_GSM_Email,...
 Site_Mapping_GSM_Email,...
 Group_Mapping_GSM_Email,...
 User_ID_Mapping_GSM_Email,...
 Cost_Center_Mapping_GSM_Email,...
 AccountNb_Mapping_GSM_Email,...
 SubAccountNb_Mapping_GSM_Email,...
 ProjectID_Mapping_GSM_Email,...
 MNO_Provider_Mapping_GSM_Email,...
 MNO_Account_Mapping_GSM_Email,...
 Cust_Acc_Nbr_Mapping_GSM_Email,...
 Manager_email_1_Mapping_GSM_Email,...
 Manager_email_2_Mapping_GSM_Email,...
 BCC_e_mail_Mapping_GSM_Email,...
 Dynamic_warning_1_Mapping_GSM_Email,...
 Dynamic_warning_2_Mapping_GSM_Email,...
 Reserved3_Mapping_GSM_Email,...
 Reserved4_Mapping_GSM_Email,...
 Reserved6_Mapping_GSM_Email,...
 Reserved9_Mapping_GSM_Email,...
 DATA_NAT_MB_Mapping_GSM_Email,...
 DATA_NAT_Sub_Mapping_GSM_Email,...
 DATA_ROAMING_MB_Mapping_GSM_Email,...
 DATA_ROAMING_Sub_Mapping_GSM_Email,...
 Threshold_Amount_Mapping_GSM_Email,...
 Budget_Mapping_GSM_Email,...
 Threshold_Amount_for_histogram_Voice_Mapping_GSM_Email,...
 Reserved7_Mapping_GSM_Email,...
 Reserved8_Mapping_GSM_Email,...
 Reserved5_Mapping_GSM_Email]=...
 textread([PathName,FileName],'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','delimiter',';','headerlines',1);
%--------------------------------------------------------------
% LECTURE DES NOMS D UTILISATEURS, dit aussi par Carlo SIM_Mapping_File
%--------------------------------------------------------------





%--------------------------------------------------------------
% LECTURE DES CDR Martyr
%--------------------------------------------------------------

if strcmp(Client_Identification,'C:\');
    temp=[':\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\'];
else
    temp=['\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\',Client_Identification,'\5_CDR_Traffic\'];
end 
[FileName,PathName] = uigetfile({'*.*','Fichier CDR';'*.*','All Files' },'Fichier CDR_Martyr',temp);

fid=fopen([PathName,FileName]);
Line=[];
Operator=[];
Account_number=[];
Remapping_CYC2=[]; % la variable Remapping_CYC2 est celle qui donne le type d'appel
Call_date=[];
When_date_time=[];
Destination_number=[];
Renaming=[];
Destination_service=[];
Country=[];
Period=[];
Consumption_unit=[];
Consumption_count=[];
Amount_for_histogram=[];
Amount_for_MUAC=[];
Amount_gross=[];
Amount_net=[];
TRUE_OR_FALSE=[];
    
for sliding_block=1:10000
  eofstat = feof(fid);
    if eofstat ==1
        break
    end 
 set(handles.edit9,'String',['Lecture du bloc',char(num2str(sliding_block))]);bidonbidon=[char(10),'Lecture du bloc',char(num2str(sliding_block))];log_file_text=[log_file_text,bidonbidon];
 drawnow; 
 if sliding_block==1
   C=textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %f %s %s %f %f %f %f %s',10000,'delimiter',';','headerlines',1);
 else
   C=textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %f %s %s %f %f %f %f %s',10000,'delimiter',';');
 end
  
 Line=[Line;C{27}];
 Operator=[Operator;C{28}];
 Account_number=[Account_number;C{29}];
 Remapping_CYC2=[Remapping_CYC2;C{31}]; % la variable Remapping_CYC2 est celle qui donne le type d'appel
 When_date_time=[When_date_time;C{37}];
 Destination_number=[Destination_number;C{34}];
 Renaming=[Renaming;C{32}];
 Destination_service=[Destination_service;C{33}];
 Consumption_unit=[Consumption_unit;C{40}];
 Consumption_count=[Consumption_count;C{39}];
 Amount_net=[Amount_net;C{43}];
 Amount_for_histogram=[Amount_for_histogram;C{44}];
 Amount_for_MUAC=[Amount_for_MUAC;C{45}];
 Amount_gross=[Amount_gross;C{42}];
 TRUE_OR_FALSE=[TRUE_OR_FALSE;C{46}];
 set(handles.edit9,'String',['déjà traité:',char(num2str(max(size(Line)))),' CDR',]);bidonbidon=[char(10),'déjà traité:',char(num2str(max(size(Line)))),' CDR',];log_file_text=[log_file_text,bidonbidon];
 drawnow;  
end
fclose(fid);    
set(handles.edit9,'String',['Le fichier contient:',num2str(max(size(Amount_gross))),' CDR']);bidonbidon=[char(10),'Le fichier contient:',num2str(max(size(Amount_gross))),' CDR'];log_file_text=[log_file_text,bidonbidon];
drawnow;

for i=1:max(size(Consumption_unit))
    if strcmp(Consumption_unit(i),'s')
        Consumption_count(i)=Consumption_count(i)/60;
    end
end
%--------------------------------------------------------------
% FIN LECTURE DES CDR Martyr
%--------------------------------------------------------------

%--------------------------------------------------------------
% ON DEJA DEMANDE A L'UTILISATEUR OU SAUVER LES RESULTATS - AINSI, CELA NE DOIT
% PAS ATTENDRE LA FIN DE L'EXECUTION DU CALCUL - ON ANTICIPE LES LIGNES DE
% CODE 883 ET SUIV.
%--------------------------------------------------------------

%if ~exist(['\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\',Client_Identification,'\7_Output\MUAC\'],'dir')
%    mkdir(['D:\3_CCZ_DEVELOPMENT\1_TestLib\',Client_Identification,'\7_Output\MUAC\']);
%end
if strcmp(Client_Identification,'C:\');
    temp=[':\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\'];
else
    temp=['\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\',Client_Identification,'\7_Output\MUAC\'];
end

PathName = uigetdir(temp,'Select directory') ;
nom_de_fichier=strcat([PathName,'\Overview_par_GSM_sur_base_de_',FileName]);

%--------------------------------------------------------------
% ON DEJA DEMANDE A L'UTILISATEUR OU SAUVER LES RESULTATS - AINSI, CELA NE DOIT
% PAS ATTENDRE LA FIN DE L'EXECUTION DU CALCUL - ON ANTICIPE LES LIGNES DE
% CODE 883 ET SUIV.
%--------------------------------------------------------------


%------------------------------------------------------------------  
% IDENTIFICATION/ENUMERATION DES GSM QUI APPARAISSENT DANS LES CDRS
%------------------------------------------------------------------  
Line_avec_TRUE_OR_FALSE_egal_a_true=[];
for i=1:max(size(Line))
    if strcmp(TRUE_OR_FALSE(i),'true') |  strcmp(TRUE_OR_FALSE(i),'TRUE')
    Line_avec_TRUE_OR_FALSE_egal_a_true=[Line_avec_TRUE_OR_FALSE_egal_a_true;Line(i)];
    end
end
critere=Line_avec_TRUE_OR_FALSE_egal_a_true;
bidon=sort(critere);
j=1;
Numero_Appelant=[bidon(1)];
for i=2:max(size(bidon))
    if ~(strcmp(bidon(i-1),bidon(i)))
        j=j+1;
        Numero_Appelant=[Numero_Appelant bidon(i)];
    end    
end
drawnow;
%------------------------------------------------------------------  
% IDENTIFICATION/ENUMERATION DES GSM QUI APPARAISSENT DANS LES CDRS
%------------------------------------------------------------------ 


%------------------------------------------------------------------  
% IDENTIFICATION/ENUMERATION DES TYPES D'APPELS dans variable etiquette 
%------------------------------------------------------------------  
critere=Remapping_CYC2;
bidon=sort(critere);
j=1;
etiquette=[bidon(1)];
for i=2:max(size(bidon))
    if ~(strcmp(bidon(i-1),bidon(i)))
        j=j+1;
        etiquette=[etiquette bidon(i)];
    end    
end
%--------------------------------------------------------------  
% IDENTIFICATION/ENUMERATION DES TYPES D'APPELS dans variable etiquette 
%--------------------------------------------------------------  

%------------------------------------------------------------------  
% IDENTIFICATION/ENUMERATION DES TYPES D'APPELS dans variable etiquette 
%------------------------------------------------------------------  
critere=Renaming;
bidon=sort(critere);
j=1;
etiquette2=[bidon(1)];
for i=2:max(size(bidon))
    if ~(strcmp(bidon(i-1),bidon(i)))
        j=j+1;
        etiquette2=[etiquette2 bidon(i)];
    end    
end
%--------------------------------------------------------------  
% IDENTIFICATION/ENUMERATION DES TYPES D'APPELS dans variable etiquette 
%--------------------------------------------------------------  

set(handles.edit9,'String',['Le fichier contient:',num2str(max(size(etiquette))),' Catégories d''Appels']);bidonbidon=[char(10),'Le fichier contient:',num2str(max(size(etiquette))),' Catégories d''Appels'];log_file_text=[log_file_text,bidonbidon];
drawnow;

%--------------------------------------------------------------------------
% FIN ON FAIT LE LIEN ENTRE LES NUMEROS DE GSM QUI APPARAISSENT DANS CDR ET CEUX DU MAPPING EMAIL 
%--------------------------------------------------------------------------
for i=1:max(size(Numero_Appelant))
  CDR_Reconnu=0;
  for k=1:max(size(GSM_Number_Mapping_GSM_Email))
    if (strcmp(Numero_Appelant(i),GSM_Number_Mapping_GSM_Email(k)))
      MUAC(i)=MUAC_Mapping_GSM_Email(k);
      if strcmp(MUAC(i),'N') |  strcmp(MUAC(i),'No') | strcmp(MUAC(i),'nO') | strcmp(MUAC(i),'no') | strcmp(MUAC(i),'NO') | strcmp(MUAC(i),'n')
          Nom_Appelant(i)={'No_MUAC'};
          if isempty(char(EMAIL_for_the_MUAC_Mapping_GSM_Email(k)))
            EMAIL_for_the_MUAC(i)=	{''};
          else
            EMAIL_for_the_MUAC(i)=	EMAIL_for_the_MUAC_Mapping_GSM_Email(k);
          end
      else
         if isempty(char(EMAIL_for_the_MUAC_Mapping_GSM_Email(k)))
            Nom_Appelant(i)={'Email for MUAC Missing'};
            EMAIL_for_the_MUAC(i)=	{'Email for MUAC Missing'};
          else
            Nom_Appelant(i)=EMAIL_for_the_MUAC_Mapping_GSM_Email(k);
            EMAIL_for_the_MUAC(i)=	EMAIL_for_the_MUAC_Mapping_GSM_Email(k);
          end
      end
      GSM_Number(i)=	GSM_Number_Mapping_GSM_Email(k);
      Identification_1(i)=	Identification_1_Mapping_GSM_Email(k);
      Identification_2(i)=	Identification_2_Mapping_GSM_Email(k);
      Device_Type(i)=	Device_Type_Mapping_GSM_Email(k);
      Own_Device(i)=	Own_Device_Mapping_GSM_Email(k);
      MUAC(i)=	MUAC_Mapping_GSM_Email(k);
      Ranking(i)=	Ranking_Mapping_GSM_Email(k);
      Language(i)=	Language_Mapping_GSM_Email(k);
      %EMAIL_for_the_MUAC(i)=	EMAIL_for_the_MUAC_Mapping_GSM_Email(k); %(traité dans le if ci-dessus)
      Reserved1(i)=	Reserved1_Mapping_GSM_Email(k);
      Reserved2(i)=	Reserved2_Mapping_GSM_Email(k);
      Company(i)=	Company_Mapping_GSM_Email(k);
      Site(i)=	Site_Mapping_GSM_Email(k);
      Group(i)=	Group_Mapping_GSM_Email(k);
      User_ID(i)=	User_ID_Mapping_GSM_Email(k);
      Cost_Center(i)=	Cost_Center_Mapping_GSM_Email(k);
      AccountNb(i)=	AccountNb_Mapping_GSM_Email(k);
      SubAccountNb(i)=	SubAccountNb_Mapping_GSM_Email(k);
      ProjectID(i)=	ProjectID_Mapping_GSM_Email(k);
      MNO_Provider(i)=	MNO_Provider_Mapping_GSM_Email(k);
      MNO_Account(i)=	MNO_Account_Mapping_GSM_Email(k);
      Cust_Acc_Nbr(i)=	Cust_Acc_Nbr_Mapping_GSM_Email(k);
      Reserved3(i)=	Reserved3_Mapping_GSM_Email(k);
      Manager_email_1(i)=	Manager_email_1_Mapping_GSM_Email(k);
      Manager_email_2(i)=	Manager_email_2_Mapping_GSM_Email(k);
      BCC_e_mail(i)=	BCC_e_mail_Mapping_GSM_Email(k);
      Dynamic_warning_1(i)=	Dynamic_warning_1_Mapping_GSM_Email(k);
      Dynamic_warning_2(i)=	Dynamic_warning_2_Mapping_GSM_Email(k);
      Reserved4(i)=	Reserved4_Mapping_GSM_Email(k);
      Reserved5(i)=	Reserved5_Mapping_GSM_Email(k);
      Reserved6(i)=	Reserved6_Mapping_GSM_Email(k);
      DATA_NAT_MB(i)=	DATA_NAT_MB_Mapping_GSM_Email(k);
      DATA_NAT_Sub(i)=	DATA_NAT_Sub_Mapping_GSM_Email(k);
      DATA_ROAMING_MB(i)=	DATA_ROAMING_MB_Mapping_GSM_Email(k);
      DATA_ROAMING_Sub(i)=	DATA_ROAMING_Sub_Mapping_GSM_Email(k);
      Threshold_Amount(i)=	Threshold_Amount_Mapping_GSM_Email(k);
      Budget(i)=	Budget_Mapping_GSM_Email(k);
      Threshold_Amount_for_histogram_Voice(i)=	Threshold_Amount_for_histogram_Voice_Mapping_GSM_Email(k);
      Reserved7(i)=	Reserved7_Mapping_GSM_Email(k);
      Reserved8(i)=	Reserved8_Mapping_GSM_Email(k);
      Reserved9(i)=	Reserved9_Mapping_GSM_Email(k);
      CDR_Reconnu=1;
      break
    end
  end


  if CDR_Reconnu==0
     GSM_Number(i)=	Numero_Appelant(i);
     Nom_Appelant(i)=	{''};
     Identification_1(i)=	{'Line_not_identified'};
     Identification_2(i)=	{''};
     Device_Type(i)=	{''};
     Own_Device(i)=	{''};
     MUAC(i)=	{''};
     Ranking(i)=	{''};
     Language(i)=	{''};
     EMAIL_for_the_MUAC(i)=	{''};
     Reserved1(i)=	{''};
     Reserved2(i)=	{''};
     Company(i)=	{''};
     Site(i)=	{''};
     Group(i)=	{''};
     User_ID(i)=	{''};
     Cost_Center(i)=	{''};
     AccountNb(i)=	{''};
     SubAccountNb(i)=	{''};
     ProjectID(i)=	{''};
     MNO_Provider(i)={''};
     MNO_Account(i)=	{''};
     Cust_Acc_Nbr(i)=	{''};
     Reserved3(i)=	{''};
     Manager_email_1(i)=	{''};
     Manager_email_2(i)=	{''};
     BCC_e_mail(i)=	CD_9_FR;
     Dynamic_warning_1(i)=	{''};
     Dynamic_warning_2(i)=	{''};
     Reserved4(i)=	{''};
     Reserved5(i)=	{''};
     Reserved6(i)=	{''};
     DATA_NAT_MB(i)=	{''};
     DATA_NAT_Sub(i)=	{''};
     DATA_ROAMING_MB(i)=	{''};
     DATA_ROAMING_Sub(i)=	{''};
     Threshold_Amount(i)=	{''};
     Budget(i)=	{''};
     Threshold_Amount_for_histogram_Voice(i)=	{''};
     Reserved7(i)=	{''};
     Reserved8(i)=	{''};
     Reserved9(i)=	{''};
  end
end
%--------------------------------------------------------------------------
% FIN ON FAIT LE LIEN ENTRE LES NUMEROS DE GSM QUI APPARAISSENT DANS CDR ET CEUX DU MAPPING EMAIL 
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
% PAR NUMERO APPELANT, ON ASSOCIE L'OPERATEUR
%--------------------------------------------------------------------------
Operator_lie_au_Numero_Appelant=[];
Account_lie_au_Numero_Appelant=[];
for i=1:max(size(Numero_Appelant))
    for j=1:max(size(Operator))
        if strcmp(Numero_Appelant(i),Line(j))
        Operator_lie_au_Numero_Appelant=[Operator_lie_au_Numero_Appelant;Operator(j)];
        Account_lie_au_Numero_Appelant=[Account_lie_au_Numero_Appelant;Account_number(j)];
        break
        end
    end
end  
%--------------------------------------------------------------------------
% FIN PAR NUMERO APPELANT, ON ASSOCIE L'OPERATEUR
%--------------------------------------------------------------------------    

%--------------------------------------------------------------
% DEBUT COEUR DU PROGRAMME
%--------------------------------------------------------------
label=etiquette;
compteur=zeros(max(size(Numero_Appelant)),max(size(etiquette)));
minute=zeros(max(size(Numero_Appelant)),max(size(etiquette)));
prix=zeros(max(size(Numero_Appelant)),max(size(etiquette)));
prix_pour_histogramme=zeros(max(size(Numero_Appelant)),max(size(etiquette)));
prix_pour_MUAC=zeros(max(size(Numero_Appelant)),max(size(etiquette)));
prix_par_Renaming=zeros(max(size(etiquette)));
minute_par_Renaming=zeros(max(size(etiquette)));
compteur_par_Renaming=zeros(max(size(etiquette)));    

compteur2=zeros(max(size(Numero_Appelant)),max(size(etiquette2)));
minute2=zeros(max(size(Numero_Appelant)),max(size(etiquette2)));
prix2=zeros(max(size(Numero_Appelant)),max(size(etiquette2)));
prix_par_Remapping_CYC2=zeros(max(size(etiquette2)));
minute_par_Remapping_CYC2=zeros(max(size(etiquette2)));
compteur_par_Remapping_CYC2=zeros(max(size(etiquette2)));  


Prix_Total=zeros(max(size(Numero_Appelant)),1);  
Prix_Total_Sans_Abonnement=zeros(max(size(Numero_Appelant)),1);
Minute_Total=zeros(max(size(Numero_Appelant)),1);
prix_pour_le_calcul_du_ranking=zeros(max(size(Numero_Appelant)),max(size(etiquette))); %V35G
Prix_Total_pour_le_calcul_du_ranking=zeros(max(size(Numero_Appelant)),1);  %V35G
Prix_Total__Sans_Abonnement_pour_le_calcul_du_ranking=zeros(max(size(Numero_Appelant)),1);  %V2_1G
for k=1:max(size(Numero_Appelant)) 
  set(handles.edit9,'String',['il reste:',num2str(max(size(Numero_Appelant))-k),' numéros à traiter']);bidonbidon=[char(10),'il reste:',num2str(max(size(Numero_Appelant))-k),' numéros à traiter'];log_file_text=[log_file_text,bidonbidon];
  drawnow;
  for i=1:max(size(Destination_number))  
    if strcmp(TRUE_OR_FALSE(i),'true') | strcmp(TRUE_OR_FALSE(i),'TRUE')
    if (strcmp(Line(i),Numero_Appelant(k)))     
        CDR_Reconnu=0;   
        l=0;   
        for j=1:max(size(etiquette))
          l=l+1;
          if strcmp(char(Remapping_CYC2(i)),char(etiquette(j)))& CDR_Reconnu==0;
             update_compteur;
          end
        end 
        if (CDR_Reconnu==0)
           % Eventuellement on met un STOP ici pour voir quel type d'appel on a loupé
        end
        
        CDR_Reconnu=0;   
        l=0;   
        for j=1:max(size(etiquette2))
           l=l+1;
           if strcmp(char(Renaming(i)),char(etiquette2(j)))& CDR_Reconnu==0;
              update_compteur2;
           end
        end
        if (CDR_Reconnu==0)
           % Eventuellement on met un STOP ici pour voir quel type d'appel on a loupé
        end     
    end 
    end
  end
 

 

 % DEBUT HISTOGRAMME UNIQUEMENT DANS VERSION G
 if  no_display_of_histogram==0
   for ll=1:max(size(label))
     Prix_Total(k)=Prix_Total(k)+prix(k,ll);
   end
   cla(handles.axes1);
   axes(handles.axes1);
   hold on
   Title(handles.axes1,'Histogram of Spending per Employee')
   hist(handles.axes1,Prix_Total(1:k,1),2*(1+log2(max(size(Prix_Total)))));
   h = findobj(gca,'Type','patch');
   set(h,'FaceColor','r')
   xlabel('Range of Spending per User');
   ylabel('Number of Users per Range of Spending');
   drawnow;
 end
 % FIN HISTOGRAMME UNIQUEMENT DANS VERSION G

  end  
  
%--------------------------------------------------------------
% FIN COEUR DU PROGRAMME
%--------------------------------------------------------------

  Prix_Total=zeros(max(size(Numero_Appelant)),1);
  Prix_Total_pour_histogramme=zeros(max(size(Numero_Appelant)),1);
  Prix_Total_pour_MUAC=zeros(max(size(Numero_Appelant)),1);
  Prix_Total_pour_le_calcul_du_ranking_dans_l_overview=zeros(max(size(Numero_Appelant)),1);
  for k=1:max(size(Numero_Appelant))  
    for l=1:max(size(label))
    Prix_Total(k)=Prix_Total(k)+prix(k,l);
    Prix_Total_pour_histogramme(k)=Prix_Total_pour_histogramme(k)+prix_pour_histogramme(k,l);
    Prix_Total_pour_MUAC(k)=Prix_Total_pour_MUAC(k)+prix_pour_MUAC(k,l);
    Minute_Total(k)=Minute_Total(k)+minute(k,l);
    if ~strcmp(label(l),'SUBSCRIPTION')
      Prix_Total_Sans_Abonnement(k)=Prix_Total_Sans_Abonnement(k)+prix(k,l);
    end
    end
  end

%************************************************************************** 
% CONCOURS BIGGEST SPENDER
%**************************************************************************
flag_contest=zeros(max(size(etiquette)),1); % cela dit si une catégorie pour laquelle on veut un ranking existe ou pas
contest=zeros(max(size(etiquette)),1);
for j=1:max(size(label))
    for i=1:max(size(Remapping_CYC2))
    if   ~isempty(max(findstr(char(Remapping_CYC2(i)),char(label(j))))>=1)
        contest(j)=j;flag_contest(j)=1;
        break
    end
    end
end

for j=1:max(size(Numero_Appelant)) %V35G
    if  ~strcmp(Ranking(j),'N') & ~strcmp(Ranking(j),'No') & ~strcmp(Ranking(j),'nO') & ~strcmp(Ranking(j),'no') & ~strcmp(Ranking(j),'NO') & ~strcmp(Ranking(j),'n')%V35G
      prix_pour_le_calcul_du_ranking(j,:)=prix(j,:); %V35G
      Prix_Total_pour_le_calcul_du_ranking(j)=Prix_Total_pour_histogramme(j); %V35G
      Prix_Total_pour_le_calcul_du_ranking_dans_l_overview(j)=Prix_Total_pour_MUAC(j); %V35G
      Prix_Total__Sans_Abonnement_pour_le_calcul_du_ranking(j)=Prix_Total_Sans_Abonnement(j); %V2_1G      
    end %V35G
end %V35G

for i=1:max(size(etiquette))
  if flag_contest(i)~=0
     Order_Prix(contest(i),:)=sort(prix_pour_le_calcul_du_ranking(:,contest(i)));
  end
end
Order_Prix_Total_pour_le_calcul_du_ranking=sort(Prix_Total_pour_le_calcul_du_ranking);
Order_Prix_Total_pour_le_calcul_du_ranking_dans_l_overview=sort(Prix_Total_pour_le_calcul_du_ranking_dans_l_overview);
Order_Prix_Total=sort(Prix_Total); %V168G Comme il y a le paramètre Ranking = No, On peut alors mettre la valeur de sa position s’il avait fait partie du ranking et non le nb total de carte Qu’en penses-tu 
Order_Prix_Total_Sans_Abonnement=sort(Prix_Total_Sans_Abonnement);
Order_Prix_Total__Sans_Abonnement_pour_le_calcul_du_ranking=sort(Prix_Total__Sans_Abonnement_pour_le_calcul_du_ranking); %V2_1G

% ON COMPTE COMBIEN DE NUMEROS GSM APPARAISSANT DANS LES CDRs IL YA POUR LESQUELS ON NE DEMANDE PAS DE RANKING
bidon=0; %V168_11G
for m=1:max(size(Numero_Appelant))
       if strcmp(Ranking(m),'N') | strcmp(Ranking(m),'No') | strcmp(Ranking(m),'nO') | strcmp(Ranking(m),'no') | strcmp(Ranking(m),'NO') | strcmp(Ranking(m),'n')%V168_11G
           bidon=bidon+1;%V168G
       end%V168_11G
end%V168_11G
% ON COMPTE COMBIEN DE NUMEROS GSM APPARAISSANT DANS LES CDRs IL YA POUR
% LESQUELS ON NE DEMANDE PAS DE RANKING


for j=1:max(size(Numero_Appelant))
    for i=max(max(size(Numero_Appelant))):-1:1
      for k=1:max(size(etiquette))
        if flag_contest(k)==1  
          if (prix_pour_le_calcul_du_ranking(j,contest(k))==Order_Prix(contest(k),i))
            Rang_contest(k,j)=max(size(Numero_Appelant))-i+1;
          end
        end
      end
      if (Prix_Total_pour_le_calcul_du_ranking(j)==Order_Prix_Total_pour_le_calcul_du_ranking(i))
         Rang_Prix_Total_pour_le_calcul_du_ranking(j)=max(size(Numero_Appelant))-i+1; %-bidon; %V168_11G on fait -bidon pour ne pas avoir un ranking > Active SIM Cards ranked this month puisque Active SIM Cards ranked this month  tient compte du nombre de cartes pour lequel un ranking n'est pas demandé.
      end
      if (Prix_Total_pour_le_calcul_du_ranking_dans_l_overview(j)==Order_Prix_Total_pour_le_calcul_du_ranking_dans_l_overview(i))
         Rang_Prix_Total_pour_le_calcul_du_ranking_dans_l_overview(j)=max(size(Numero_Appelant))-i+1; %-bidon; %V168_11G on fait -bidon pour ne pas avoir un ranking > Active SIM Cards ranked this month puisque Active SIM Cards ranked this month  tient compte du nombre de cartes pour lequel un ranking n'est pas demandé.
      end
      if (Prix_Total(j)==Order_Prix_Total(i)) %V168G Comme il y a le paramètre Ranking = No, On peut alors mettre la valeur de sa position s’il avait fait partie du ranking et non le nb total de carte Qu’en penses-tu 
         Rang_Prix_Total(j)=max(size(Numero_Appelant))-i+1;%V168G Comme il y a le paramètre Ranking = No, On peut alors mettre la valeur de sa position s’il avait fait partie du ranking et non le nb total de carte Qu’en penses-tu 
      end %V168G Comme il y a le paramètre Ranking = No, On peut alors mettre la valeur de sa position s’il avait fait partie du ranking et non le nb total de carte Qu’en penses-tu 
      if (Prix_Total_Sans_Abonnement(j)==Order_Prix_Total_Sans_Abonnement(i))
         Rang_Prix_Total_Sans_Abonnement(j)=max(size(Numero_Appelant))-i+1;;
      end
      if (Prix_Total__Sans_Abonnement_pour_le_calcul_du_ranking(j)==Order_Prix_Total__Sans_Abonnement_pour_le_calcul_du_ranking(i)) %V2_1G
         Rang_Prix_Total__Sans_Abonnement_pour_le_calcul_du_ranking(j)=max(size(Numero_Appelant))-i+1; %V2_1G
      end %V2_1G
    end
end 
%************************************************************************** 
% FIN CONCOURS BIGGEST SPENDER
%**************************************************************************


%******************************************** 
% DEBUT SAUVETAGE TABLEAU POUR FLEET MANAGER
%********************************************

%if ~exist(['\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\',Client_Identification,'\7_Output\MUAC\'],'dir')
%    mkdir(['D:\3_CCZ_DEVELOPMENT\1_TestLib\',Client_Identification,'\7_Output\MUAC\']);
%end
%if strcmp(Client_Identification,'C:\');
%    temp=[':\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\'];
%else
%    temp=['\\BEC2SRVR-MSTR2\ProdLib\1_ClientLib\',Client_Identification,'\7_Output\MUAC\'];
%end

%PathName = uigetdir(temp,'Select directory') ;
%nom_de_fichier=strcat([PathName,'\Overview_par_GSM_sur_base_de_',FileName]);

fid = fopen(nom_de_fichier,'wb');

fprintf(fid,'%s',';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
fprintf(fid,'%s',['SUMMARY;;;SUBSCRIPTION;;;NATIONAL;;;INTERNATIONAL;;;SMS;;;ROAMING_VOICE;;;DATA_NATIONAL;;;DATA_INTERNATIONAL;;;MOBILE_COMMERCE;;;MULTIMEDIA;;;OTHER;;;']);
fprintf(fid,'%c',';');
fprintf(fid,'%s',';');
fprintf(fid,'%c',';');
fprintf(fid,'\n');

fprintf(fid,'%s',';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Units;Gross Amount;Net_Amount;');
for l=1:10
fprintf(fid,'%s','UNITS');
fprintf(fid,'%c',';');
fprintf(fid,'%s','UNITS');
fprintf(fid,'%s',';');
fprintf(fid,'%s','COSTS');
fprintf(fid,'%c',';');
end
fprintf(fid,'\n');


fprintf(fid,'%s',[char(GSM_Number_Mapping_GSM_Email(1)),';',  char(  Identification_1_Mapping_GSM_Email(1)),';',  char(  Identification_2_Mapping_GSM_Email(1)),';',  char(  Device_Type_Mapping_GSM_Email(1)),';',  char(  Own_Device_Mapping_GSM_Email(1)),';',  char(  MUAC_Mapping_GSM_Email(1)),';',  char(  Ranking_Mapping_GSM_Email(1)),';',  char(  Language_Mapping_GSM_Email(1)),';',  char(  EMAIL_for_the_MUAC_Mapping_GSM_Email(1)),';',  char(  Reserved1_Mapping_GSM_Email(1)),';',  char(  Reserved2_Mapping_GSM_Email(1)),';',  char(  Company_Mapping_GSM_Email(1)),';',  char(  Site_Mapping_GSM_Email(1)),';',  char(  Group_Mapping_GSM_Email(1)),';',  char(  User_ID_Mapping_GSM_Email(1)),';',  char(  Cost_Center_Mapping_GSM_Email(1)),';',  char(  AccountNb_Mapping_GSM_Email(1)),';',  char(  SubAccountNb_Mapping_GSM_Email(1)),';',  char(  ProjectID_Mapping_GSM_Email(1)),';',  char(  MNO_Provider_Mapping_GSM_Email(1)),';',  char(  MNO_Account_Mapping_GSM_Email(1)),';',  char(  Cust_Acc_Nbr_Mapping_GSM_Email(1)),';',char( Manager_email_1_Mapping_GSM_Email(1)),';',char( Manager_email_2_Mapping_GSM_Email(1)),';',char( BCC_e_mail_Mapping_GSM_Email(1)),';',char( Dynamic_warning_1_Mapping_GSM_Email(1)),';',char( Dynamic_warning_2_Mapping_GSM_Email(1)),';',char( Reserved3_Mapping_GSM_Email(1)),';',char( Reserved4_Mapping_GSM_Email(1)),';',char( Reserved6_Mapping_GSM_Email(1)),';',char( Reserved9_Mapping_GSM_Email(1)),';',char( DATA_NAT_MB_Mapping_GSM_Email(1)),';',char( DATA_NAT_Sub_Mapping_GSM_Email(1)),';',char( DATA_ROAMING_MB_Mapping_GSM_Email(1)),';',char( DATA_ROAMING_Sub_Mapping_GSM_Email(1)),';',char( Threshold_Amount_Mapping_GSM_Email(1)),';',char( Budget_Mapping_GSM_Email(1)),';',char( Threshold_Amount_for_histogram_Voice_Mapping_GSM_Email(1)),';',char( Reserved7_Mapping_GSM_Email(1)),';',char( Reserved8_Mapping_GSM_Email(1)),';',char( Reserved5_Mapping_GSM_Email(1)),';','Operator;Account;']);
%fprintf(fid,'%s','Line_Number;Identification_1;Identification_2;Device Type;Own Device;MUAC;RANKING;LANGUAGE;E-MAIL_for_the_MUAC;Reserved;Reserved;Company;Site;Group/Depart.;User ID;Cost_Center;Account_Nb;Sub-Account_Nb;Project_Id;MNO_Provider;MNO_Account_NB;Cust Acc Nbr;SIM Id;Manager_email_1;Manager_email_2;BCC_email;Dynamic_warning_1;Dynamic_warning_2;Reserved;Reserved;Reserved;DATA_NAT_MB;DATA_NAT_Sub;DATA_ROAMING_MB;DATA_ROAMING_Sub;Threshold_Amount;Budget (Y/N);Threshold_Amount;Reserved;Reserved;Reserved;Operator;Account;');
fprintf(fid,'%f',sum(Minute_Total(:)));
fprintf(fid,'%c',';');
bidon1=0;
bidon2=0;
for j=1:max(size(Line))
  if strcmp(TRUE_OR_FALSE(j),'true') |  strcmp(TRUE_OR_FALSE(j),'TRUE')
  bidon1=bidon1+Amount_gross(j);
  bidon2=bidon2+Amount_net(j);
  end
end
fprintf(fid,'%f',bidon1);
fprintf(fid,'%c',';');
fprintf(fid,'%f',bidon2);
fprintf(fid,'%c',';');
  
bidon=0;for j=1:max(size(label))
if strcmp(label(j),'SUBSCRIPTION') fprintf(fid,'%f',sum(compteur(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(minute(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(prix(:,j)));fprintf(fid,'%c',';');bidon=1;end
end
if bidon==0 fprintf(fid,'%s','0;0;0;');end

bidon=0;for j=1:max(size(label))
if strcmp(label(j),'NATIONAL') fprintf(fid,'%f',sum(compteur(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(minute(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(prix(:,j)));fprintf(fid,'%c',';');bidon=1;end
end
if bidon==0 fprintf(fid,'%s','0;0;0;');end

bidon=0;for j=1:max(size(label))
if strcmp(label(j),'INTERNATIONAL') fprintf(fid,'%f',sum(compteur(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(minute(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(prix(:,j)));fprintf(fid,'%c',';');bidon=1;end
end
if bidon==0 fprintf(fid,'%s','0;0;0;');end

bidon=0;for j=1:max(size(label))
if strcmp(label(j),'SMS') fprintf(fid,'%f',sum(compteur(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(minute(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(prix(:,j)));fprintf(fid,'%c',';');bidon=1;end
end
if bidon==0 fprintf(fid,'%s','0;0;0;');end

bidon=0;for j=1:max(size(label))
if strcmp(label(j),'ROAMING_VOICE') fprintf(fid,'%f',sum(compteur(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(minute(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(prix(:,j)));fprintf(fid,'%c',';');bidon=1;end
end
if bidon==0 fprintf(fid,'%s','0;0;0;');end

bidon=0;for j=1:max(size(label))
if strcmp(label(j),'DATA_NATIONAL') fprintf(fid,'%f',sum(compteur(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(minute(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(prix(:,j)));fprintf(fid,'%c',';');bidon=1;end
end
if bidon==0 fprintf(fid,'%s','0;0;0;');end

bidon=0;for j=1:max(size(label))
if strcmp(label(j),'DATA_INTERNATIONAL') fprintf(fid,'%f',sum(compteur(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(minute(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(prix(:,j)));fprintf(fid,'%c',';');bidon=1;end
end
if bidon==0 fprintf(fid,'%s','0;0;0;');end

bidon=0;for j=1:max(size(label))
if strcmp(label(j),'MOBILE_COMMERCE') fprintf(fid,'%f',sum(compteur(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(minute(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(prix(:,j)));fprintf(fid,'%c',';');bidon=1;end
end
if bidon==0 fprintf(fid,'%s','0;0;0;');end

bidon=0;for j=1:max(size(label))
if strcmp(label(j),'MULTIMEDIA') fprintf(fid,'%f',sum(compteur(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(minute(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(prix(:,j)));fprintf(fid,'%c',';');bidon=1;end
end
if bidon==0 fprintf(fid,'%s','0;0;0;');end

bidon=0;for j=1:max(size(label))
if strcmp(label(j),'OTHER') fprintf(fid,'%f',sum(compteur(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(minute(:,j)));fprintf(fid,'%c',';');fprintf(fid,'%f',sum(prix(:,j)));fprintf(fid,'%c',';');bidon=1;end
end
if bidon==0 fprintf(fid,'%s','0;0;0;');end

fprintf(fid,'\n');

for k=1:max(size(Numero_Appelant))
  fprintf(fid,'%s',[char(GSM_Number(k)),';']);
  fprintf(fid,'%s',[char(Identification_1(k)),';']);
  fprintf(fid,'%s',[char(Identification_2(k)),';']);
  fprintf(fid,'%s',[char(Device_Type(k)),';']);
  fprintf(fid,'%s',[char(Own_Device(k)),';']);
  fprintf(fid,'%s',[char(MUAC(k)),';']);
  fprintf(fid,'%s',[char(Ranking(k)),';']);
  fprintf(fid,'%s',[char(Language(k)),';']);
  fprintf(fid,'%s',[char(EMAIL_for_the_MUAC(k)),';']);
  fprintf(fid,'%s',[char(Reserved1(k)),';']);
  fprintf(fid,'%s',[char(Reserved2(k)),';']);
  fprintf(fid,'%s',[char(Company(k)),';']);
  fprintf(fid,'%s',[char(Site(k)),';']);
  fprintf(fid,'%s',[char(Group(k)),';']);
  fprintf(fid,'%s',[char(User_ID(k)),';']);
  fprintf(fid,'%s',[char(Cost_Center(k)),';']);
  fprintf(fid,'%s',[char(AccountNb(k)),';']);
  fprintf(fid,'%s',[char(SubAccountNb(k)),';']);
  fprintf(fid,'%s',[char(ProjectID(k)),';']);
  fprintf(fid,'%s',[char(MNO_Provider(k)),';']);
  fprintf(fid,'%s',[char(MNO_Account(k)),';']);
  fprintf(fid,'%s',[char(Cust_Acc_Nbr(k)),';']);
  fprintf(fid,'%s',[char(Manager_email_1(k)),';']);
  fprintf(fid,'%s',[char(Manager_email_2(k)),';']);
  fprintf(fid,'%s',[char(BCC_e_mail(k)),';']);
  fprintf(fid,'%s',[char(Dynamic_warning_1(k)),';']);
  fprintf(fid,'%s',[char(Dynamic_warning_2(k)),';']);
  fprintf(fid,'%s',[char(Reserved3(k)),';']);
  fprintf(fid,'%s',[char(Reserved4(k)),';']);
  fprintf(fid,'%s',[char(Reserved6(k)),';']);
  fprintf(fid,'%s',[char(Reserved9(k)),';']);
  fprintf(fid,'%s',[char(DATA_NAT_MB(k)),';']);
  fprintf(fid,'%s',[char(DATA_NAT_Sub(k)),';']);
  fprintf(fid,'%s',[char(DATA_ROAMING_MB(k)),';']);
  fprintf(fid,'%s',[char(DATA_ROAMING_Sub(k)),';']);
  fprintf(fid,'%s',[char(Threshold_Amount(k)),';']);
  fprintf(fid,'%s',[char(Budget(k)),';']);
  fprintf(fid,'%s',[char(Threshold_Amount_for_histogram_Voice(k)),';']);
  fprintf(fid,'%s',[char(Reserved7(k)),';']);
  fprintf(fid,'%s',[char(Reserved8(k)),';']);
  fprintf(fid,'%s',[char(Reserved5(k)),';']);
  fprintf(fid,'%s',[char(Operator_lie_au_Numero_Appelant(k)),';']);
  fprintf(fid,'%s',[char(Account_lie_au_Numero_Appelant(k)),';']);
  fprintf(fid,'%f',Minute_Total(k));
  fprintf(fid,'%c',';');
  bidon1=0;
  bidon2=0;
  for j=1:max(size(Line))
    if strcmp(Line(j),Numero_Appelant(k)) & (strcmp(TRUE_OR_FALSE(j),'true') |  strcmp(TRUE_OR_FALSE(j),'TRUE'))
    bidon1=bidon1+Amount_gross(j);
    bidon2=bidon2+Amount_net(j);
    end
  end
  fprintf(fid,'%f',bidon1);
  fprintf(fid,'%c',';');
  fprintf(fid,'%f',bidon2);
  
  
 
 bidon=0;for j=1:max(size(label))
  if strcmp(label(j),'SUBSCRIPTION') fprintf(fid,'%s',[';',char(num2str(compteur(k,j))),';',char(num2str(minute(k,j))),';',char(num2str(prix(k,j)))]);bidon=1;end
  end
  if bidon==0 fprintf(fid,'%s',';0;0;0');end
  
  bidon=0;for j=1:max(size(label))
  if strcmp(label(j),'NATIONAL') fprintf(fid,'%s',[';',char(num2str(compteur(k,j))),';',char(num2str(minute(k,j))),';',char(num2str(prix(k,j)))]);bidon=1;end
  end
  if bidon==0 fprintf(fid,'%s',';0;0;0');end
  
  bidon=0;for j=1:max(size(label))
  if strcmp(label(j),'INTERNATIONAL') fprintf(fid,'%s',[';',char(num2str(compteur(k,j))),';',char(num2str(minute(k,j))),';',char(num2str(prix(k,j)))]);bidon=1;end
  end
  if bidon==0 fprintf(fid,'%s',';0;0;0');end
  
  bidon=0;for j=1:max(size(label))
  if strcmp(label(j),'SMS') fprintf(fid,'%s',[';',char(num2str(compteur(k,j))),';',char(num2str(minute(k,j))),';',char(num2str(prix(k,j)))]);bidon=1;end
  end
  if bidon==0 fprintf(fid,'%s',';0;0;0');end
  
  bidon=0;for j=1:max(size(label))
  if strcmp(label(j),'ROAMING_VOICE') fprintf(fid,'%s',[';',char(num2str(compteur(k,j))),';',char(num2str(minute(k,j))),';',char(num2str(prix(k,j)))]);bidon=1;end
  end
  if bidon==0 fprintf(fid,'%s',';0;0;0');end
  
  bidon=0;for j=1:max(size(label))
  if strcmp(label(j),'DATA_NATIONAL') fprintf(fid,'%s',[';',char(num2str(compteur(k,j))),';',char(num2str(minute(k,j))),';',char(num2str(prix(k,j)))]);bidon=1;end
  end
  if bidon==0 fprintf(fid,'%s',';0;0;0');end
  
  bidon=0;for j=1:max(size(label))
  if strcmp(label(j),'DATA_INTERNATIONAL') fprintf(fid,'%s',[';',char(num2str(compteur(k,j))),';',char(num2str(minute(k,j))),';',char(num2str(prix(k,j)))]);bidon=1;end
  end
  if bidon==0 fprintf(fid,'%s',';0;0;0');end
  
  bidon=0;for j=1:max(size(label))
  if strcmp(label(j),'MOBILE_COMMERCE') fprintf(fid,'%s',[';',char(num2str(compteur(k,j))),';',char(num2str(minute(k,j))),';',char(num2str(prix(k,j)))]);bidon=1;end
  end
  if bidon==0 fprintf(fid,'%s',';0;0;0');end
  
  bidon=0;for j=1:max(size(label))
  if strcmp(label(j),'MULTIMEDIA') fprintf(fid,'%s',[';',char(num2str(compteur(k,j))),';',char(num2str(minute(k,j))),';',char(num2str(prix(k,j)))]);bidon=1;end
  end
  if bidon==0 fprintf(fid,'%s',';0;0;0');end
  
  bidon=0;for j=1:max(size(label))
  if strcmp(label(j),'OTHER') fprintf(fid,'%s',[';',char(num2str(compteur(k,j))),';',char(num2str(minute(k,j))),';',char(num2str(prix(k,j)))]); bidon=1;end
  end
  if bidon==0 fprintf(fid,'%s',';0;0;0');end
  
  if strcmp(Ranking(k),'N') | strcmp(Ranking(k),'No') | strcmp(Ranking(k),'nO') | strcmp(Ranking(k),'no') | strcmp(Ranking(k),'NO') | strcmp(Ranking(k),'n')%V168_12
      fprintf(fid,'%c',';'); 
      fprintf(fid,'%s','NotRanked'); %V168_12
  else
      fprintf(fid,'%c',';');
      fprintf(fid,'%u',Rang_Prix_Total_pour_le_calcul_du_ranking_dans_l_overview(k)); %V168_12
  end %V168_12

  
  
  fprintf(fid,'\n');

end

fprintf(fid,'%s','FIN_OVERVIEW');
fprintf(fid,'\n');
fprintf(fid,'\n');
fclose(fid);
%******************************************** 
% FIN SAUVETAGE TABLEAU POUR FLEET MANAGER
%********************************************


%******************************************** 
% SAUVETAGE TABLEAU PAR GSM
%******************************************** 

if no_generation_of_MUAC==0
for k=1:max(size(Numero_Appelant))
  test=char(Numero_Appelant(k));
  CD_1=CD_1_EN;CD_2=CD_2_EN;CD_3=CD_3_EN;CD_4=CD_4_EN;CD_5=CD_5_EN;CD_6=CD_6_EN;CD_7=CD_7_EN;CD_8=CD_8_EN;
  TR_1=TR_1_EN;TR_2=TR_2_EN;TR_3=TR_3_EN;TR_4=TR_4_EN;TR_5=TR_5_EN;TR_6=TR_6_EN;TR_7=TR_7_EN;TR_8=TR_8_EN;TR_9=TR_9_EN;TR_10=TR_10_EN;TR_11=TR_11_EN;TR_12=TR_12_EN;TR_13=TR_13_EN;TR_14=TR_14_EN;TR_15=TR_15_EN;
  CS_1=CS_1_EN;CS_2=CS_2_EN;CS_3=CS_3_EN;CS_4=CS_4_EN;CS_5=CS_5_EN;CS_6=CS_6_EN;CS_7=CS_7_EN;CS_8=CS_8_EN;
  HIST_1=HIST_1_EN;HIST_2=HIST_2_EN;HIST_3=HIST_3_EN;HIST_4=HIST_4_EN;HIST_5=HIST_5_EN;HIST_6=HIST_6_EN;
  if strcmp(Language(k),'FR')
  CD_1=CD_1_FR;CD_2=CD_2_FR;CD_3=CD_3_FR;CD_4=CD_4_FR;CD_5=CD_5_FR;CD_6=CD_6_FR;CD_7=CD_7_FR;CD_8=CD_8_FR;
  TR_1=TR_1_FR;TR_2=TR_2_FR;TR_3=TR_3_FR;TR_4=TR_4_FR;TR_5=TR_5_FR;TR_6=TR_6_FR;TR_7=TR_7_FR;TR_8=TR_8_FR;TR_9=TR_9_FR;TR_10=TR_10_FR;TR_11=TR_11_FR;TR_12=TR_12_FR;TR_13=TR_13_FR;TR_14=TR_14_FR;TR_15=TR_15_FR;
  CS_1=CS_1_FR;CS_2=CS_2_FR;CS_3=CS_3_FR;CS_4=CS_4_FR;CS_5=CS_5_FR;CS_6=CS_6_FR;CS_7=CS_7_FR;CS_8=CS_8_FR;
  HIST_1=HIST_1_FR;HIST_2=HIST_2_FR;HIST_3=HIST_3_FR;HIST_4=HIST_4_FR;HIST_5=HIST_5_FR;HIST_6=HIST_6_FR;
  end
  if strcmp(Language(k),'NL')
  CD_1_=CD_1_NL;CD_2=CD_2_NL;CD_3=CD_3_NL;CD_4=CD_4_NL;CD_5=CD_5_NL;CD_6=CD_6_NL;CD_7=CD_7_NL;CD_8=CD_8_NL;
  TR_1=TR_1_NL;TR_2=TR_2_NL;TR_3=TR_3_NL;TR_4=TR_4_NL;TR_5=TR_5_NL;TR_6=TR_6_NL;TR_7=TR_7_NL;TR_8=TR_8_NL;TR_9=TR_9_NL;TR_10=TR_10_NL;TR_11=TR_11_NL;TR_12=TR_12_NL;TR_13=TR_13_NL;TR_14=TR_14_NL;TR_15=TR_15_NL;
  CS_1=CS_1_NL;CS_2=CS_2_NL;CS_3=CS_3_NL;CS_4=CS_4_NL;CS_5=CS_5_NL;CS_6=CS_6_NL;CS_7=CS_7_NL;CS_8=CS_8_NL;
  HIST_1=HIST_1_NL;HIST_2=HIST_2_NL;HIST_3=HIST_3_NL;HIST_4=HIST_4_NL;HIST_5=HIST_5_NL;HIST_6=HIST_6_NL;
  end
  if strcmp(Language(k),'GE')
  CD_1=CD_1_GE;CD_2=CD_2_GE;CD_3=CD_3_GE;CD_4=CD_4_GE;CD_5=CD_5_GE;CD_6=CD_6_GE;CD_7=CD_7_GE;CD_8=CD_8_GE;
  TR_1=TR_1_GE;TR_2=TR_2_GE;TR_3=TR_3_GE;TR_4=TR_4_GE;TR_5=TR_5_GE;TR_6=TR_6_GE;TR_7=TR_7_GE;TR_8=TR_8_GE;TR_9=TR_9_GE;TR_10=TR_10_GE;TR_11=TR_11_GE;TR_12=TR_12_GE;TR_13=TR_13_GE;TR_14=TR_14_GE;TR_15=TR_15_GE;
  CS_1=CS_1_GE;CS_2=CS_2_GE;CS_3=CS_3_GE;CS_4=CS_4_GE;CS_5=CS_5_GE;CS_6=CS_6_GE;CS_7=CS_7_GE;CS_8=CS_8_GE;
  HIST_1=HIST_1_GE;HIST_2=HIST_2_GE;HIST_3=HIST_3_GE;HIST_4=HIST_4_GE;HIST_5=HIST_5_GE;HIST_6=HIST_6_GE;
  end
  if strcmp(Language(k),'IT')
  CD_1=CD_1_IT;CD_2=CD_2_IT;CD_3=CD_3_IT;CD_4=CD_4_IT;CD_5=CD_5_IT;CD_6=CD_6_IT;CD_7=CD_7_IT;CD_8=CD_8_IT;
  TR_1=TR_1_IT;TR_2=TR_2_IT;TR_3=TR_3_IT;TR_4=TR_4_IT;TR_5=TR_5_IT;TR_6=TR_6_IT;TR_7=TR_7_IT;TR_8=TR_8_IT;TR_9=TR_9_IT;TR_10=TR_10_IT;TR_11=TR_11_IT;TR_12=TR_12_IT;TR_13=TR_13_IT;TR_14=TR_14_IT;TR_15=TR_15_IT;
  CS_1=CS_1_IT;CS_2=CS_2_IT;CS_3=CS_3_IT;CS_4=CS_4_IT;CS_5=CS_5_IT;CS_6=CS_6_IT;CS_7=CS_7_IT;CS_8=CS_8_IT;
  HIST_1=HIST_1_IT;HIST_2=HIST_2_IT;HIST_3=HIST_3_IT;HIST_4=HIST_4_IT;HIST_5=HIST_5_IT;HIST_6=HIST_6_IT;
  end

  for i=1:max(size(test))
      if test(i)=='/' 
         test(i)='_';
      end
  end
  bidon=test;
  set(handles.edit9,'String',['le reporting de ',char(Nom_Appelant(k)),'-',char(GSM_Number(k)),' est sauvé - il en reste:',num2str(max(size(Numero_Appelant))-k),' à traiter']);bidonbidon=[char(10),'le reporting de ',char(Nom_Appelant(k)),' est sauvé - il en reste:',num2str(max(size(Numero_Appelant))-k),' à traiter'];log_file_text=[log_file_text,bidonbidon];
  drawnow;

    
  nom_de_fichier=strcat([PathName,'\',char(bidon),'__(',char(EMAIL_for_the_MUAC(k)),')_',FileName]);bidonbidon=[char(10),'sauvé sous ',nom_de_fichier];log_file_text=[log_file_text,bidonbidon];
%  nom_de_fichier=strcat([PathName,char(bidon),'__',FileName]);
  fid = fopen(nom_de_fichier,'wb');
  Nombre_d_appels=0; % 30.04.13 ne semble pas être utilisé - j'ai mis sou commentaire avant de deleter definitivement
  Nombre_de_Renamings=0; 
  Nombre_de_contest=0;
  for  l=1:max(size(etiquette2))
    if  (compteur2(k,l)~=0) 
      Nombre_de_Renamings=Nombre_de_Renamings+1;
    end 
  end
  for  l=1:max(size(etiquette))  % 30.04.13 ne semble pas être utilisé - j'ai mis sou commentaire avant de deleter definitivement 
    if  ~strcmp(etiquette(l),'SUBSCRIPTION')  % 30.04.13  ne semble  pas être utilisé - j'ai mis sou commentaire avant de deleter definitivement
      Nombre_d_appels=Nombre_d_appels+compteur(k,l); % 30.04.13  ne semble pas être utilisé - j'ai mis sou commentaire avant de deleter definitivement
    end % 30.04.13  ne semble pas être utilisé - j'ai mis sou commentaire avant de deleter definitivement
  end %  30.04.13  ne semble pas être utilisé - j'ai mis sou commentaire avant de deleter definitivement
  for m=1:max(size(etiquette))
    if flag_contest(m)==1  
      if prix(k,contest(m))~=0; Nombre_de_contest=Nombre_de_contest+1; end
    end
  end
  fprintf(fid,'%s',char(CS_1));
  fprintf(fid,'%c',';');
  fprintf(fid,'%s',char(CS_2));
  fprintf(fid,'%c',';');
  fprintf(fid,'%s',char(CS_3));
  fprintf(fid,'%c',';');
  fprintf(fid,'%s',char(CS_4));
  fprintf(fid,'%c',';');
  fprintf(fid,'%s',char(CS_5));
  fprintf(fid,'%c',';');
  fprintf(fid,'%s ',char(CS_6));
  fprintf(fid,'%s',';;;;;;');
 
  fprintf(fid,'%f',Prix_Total_Sans_Abonnement(k));  
  fprintf(fid,'%c',';');
  fprintf(fid,'%f',Prix_Total(k));
  fprintf(fid,'%c',';');
  if ~strcmp(Ranking(k),'N') & ~strcmp(Ranking(k),'No') & ~strcmp(Ranking(k),'nO') & ~strcmp(Ranking(k),'no') & ~strcmp(Ranking(k),'NO') & ~strcmp(Ranking(k),'n')%V168G
      fprintf(fid,'%u',Rang_Prix_Total_pour_le_calcul_du_ranking(k)); 
  else %V168G
      fprintf(fid,'%u',Rang_Prix_Total(k)); %V168G
  end %V168G

  fprintf(fid,'%c',';');
  fprintf(fid,'%u',Nombre_d_appels);
  fprintf(fid,'%c',';');
  fprintf(fid,'%u ',Nombre_de_Renamings);
  fprintf(fid,'%c',';');
  if strcmp(Ranking(k),'N') | strcmp(Ranking(k),'No') | strcmp(Ranking(k),'nO') | strcmp(Ranking(k),'no') | strcmp(Ranking(k),'NO') | strcmp(Ranking(k),'n')%V35G
      fprintf(fid,'%c ','0');
  else
      fprintf(fid,'%u ',Nombre_de_contest);
  end
  fprintf(fid,'%c',';');
  fprintf(fid,'%4.3f',Median(Prix_Total(:)));
  fprintf(fid,'%c',';');
  fprintf(fid,'%4.3f',Mean(Prix_Total(:)));

  
fprintf(fid,'%s',[';',char(Numero_Appelant(k)),';']);
fprintf(fid,'%s',[char(Nom_Appelant(k)),';']);
fprintf(fid,'%s',[char(GSM_Number(k)),';']);
fprintf(fid,'%s',[char(Identification_1(k)),';']);
fprintf(fid,'%s',[char(Identification_2(k)),';']);
fprintf(fid,'%s',[char(Device_Type(k)),';']);
fprintf(fid,'%s',[char(Own_Device(k)),';']);
fprintf(fid,'%s',[char(MUAC(k)),';']);
fprintf(fid,'%s',[char(Ranking(k)),';']);
fprintf(fid,'%s',[char(Language(k)),';']);
fprintf(fid,'%s',[char(EMAIL_for_the_MUAC(k)),';']);
fprintf(fid,'%s',[char(Reserved1(k)),';']);
fprintf(fid,'%s',[char(Reserved2(k)),';']);
fprintf(fid,'%s',[char(Company(k)),';']);
fprintf(fid,'%s',[char(Site(k)),';']);
fprintf(fid,'%s',[char(Group(k)),';']);
fprintf(fid,'%s',[char(User_ID(k)),';']);
fprintf(fid,'%s',[char(Cost_Center(k)),';']);
fprintf(fid,'%s',[char(AccountNb(k)),';']);
fprintf(fid,'%s',[char(SubAccountNb(k)),';']);
fprintf(fid,'%s',[char(ProjectID(k)),';']);
fprintf(fid,'%s',[char(MNO_Provider(k)),';']);
fprintf(fid,'%s',[char(MNO_Account(k)),';']);
fprintf(fid,'%s',[char(Cust_Acc_Nbr(k)),';']);
fprintf(fid,'%s',[char(Reserved3(k)),';']);
fprintf(fid,'%s',[char(Manager_email_1(k)),';']);
fprintf(fid,'%s',[char(Manager_email_2(k)),';']);
fprintf(fid,'%s',[char(BCC_e_mail(k)),';']);
fprintf(fid,'%s',[char(Dynamic_warning_1(k)),';']);
fprintf(fid,'%s',[char(Dynamic_warning_2(k)),';']);
fprintf(fid,'%s',[char(Reserved4(k)),';']);
fprintf(fid,'%s',[char(Reserved5(k)),';']);
fprintf(fid,'%s',[char(Reserved6(k)),';']);
fprintf(fid,'%s',[char(DATA_NAT_MB(k)),';']);
fprintf(fid,'%s',[char(DATA_NAT_Sub(k)),';']);
fprintf(fid,'%s',[char(DATA_ROAMING_MB(k)),';']);
fprintf(fid,'%s',[char(DATA_ROAMING_Sub(k)),';']);
fprintf(fid,'%s',[char(Threshold_Amount(k)),';']);
fprintf(fid,'%s',[char(Budget(k)),';']);
fprintf(fid,'%s',[char(Threshold_Amount_for_histogram_Voice(k)),';']);
fprintf(fid,'%s',[char(Reserved7(k)),';']);
fprintf(fid,'%s',[char(Reserved8(k)),';']);
fprintf(fid,'%s',[char(Reserved9(k)),';']);
fprintf(fid,'%s',[char(HIST_1),';',char(HIST_2),';',char(HIST_3),';',char(HIST_4),';',char(HIST_5),';',char(HIST_6),';']);

% ---------------------------------------------------------------------  
%ON AJOUTE LE NBRE DE CARTES SIM ACTIVES ET PRISES EN COMPTE DANS LE RANKING
% ---------------------------------------------------------------------
bidon=0; %V168G
  for m=1:max(size(Numero_Appelant))
    if ~strcmp(Ranking(m),'N') & ~strcmp(Ranking(m),'No') & ~strcmp(Ranking(m),'nO') & ~strcmp(Ranking(m),'no') & ~strcmp(Ranking(m),'NO') & ~strcmp(Ranking(m),'n')%V168G  
        bidon=bidon+1;%V168G
    end%V168G
  end%V168G
  if bidon~=max(size(Numero_Appelant))
    fprintf(fid,'%u',bidon);%V168G
  else
    fprintf(fid,'%u',max(size(Numero_Appelant)));%V168G
  end
% ---------------------------------------------------------------------
%ON AJOUTE LE NBRE DE CARTES SIM ACTIVES ET PRISES EN COMPTE DANS LE RANKING
% ---------------------------------------------------------------------
fprintf(fid,'%c \n',';');
for l=1:max(size(etiquette2))
  if ~(compteur2(k,l)==0) 
    fprintf(fid,'%s',char(etiquette2(l)));
    fprintf(fid,'%c',';');
    for ii=1:max(size(Destination_number))
          if strcmp(Renaming(ii),etiquette2(l)) & strcmp(Line(ii),Numero_Appelant(k))  % version 1.7
          bidonbidonbidon=0; % version 1.7
          if strcmpi(Remapping_CYC2(ii),TR_4_NEUTRE) % version 1.7
              fprintf(fid,'%s',char(TR_4)); % version 1.7
              bidonbidonbidon=1; % version 1.7
          end  % version 1.7
          if strcmpi(Remapping_CYC2(ii),TR_5_NEUTRE) % version 1.7
              fprintf(fid,'%s',char(TR_5)); % version 1.7
              bidonbidonbidon=1; % version 1.7
          end % version 1.7
          if strcmpi(Remapping_CYC2(ii),TR_6_NEUTRE) % version 1.7
              fprintf(fid,'%s',char(TR_6)); % version 1.7
              bidonbidonbidon=1; % version 1.7
          end % version 1.7
          if strcmpi(Remapping_CYC2(ii),TR_7_NEUTRE) % version 1.7
              fprintf(fid,'%s',char(TR_7)); % version 1.7
              bidonbidonbidon=1; % version 1.7
          end % version 1.7
          if strcmpi(Remapping_CYC2(ii),TR_8_NEUTRE) % version 1.7
              fprintf(fid,'%s',char(TR_8)); % version 1.7
              bidonbidonbidon=1; % version 1.7
          end % version 1.7
          if strcmpi(Remapping_CYC2(ii),TR_9_NEUTRE) % version 1.7
              fprintf(fid,'%s',char(TR_9)); % version 1.7
              bidonbidonbidon=1; % version 1.7
          end % version 1.7
          if strcmpi(Remapping_CYC2(ii),TR_10_NEUTRE) % version 1.7
              fprintf(fid,'%s',char(TR_10)); % version 1.7
              bidonbidonbidon=1; % version 1.7
          end % version 1.7
          if strcmpi(Remapping_CYC2(ii),TR_11_NEUTRE) % version 1.7
              fprintf(fid,'%s',char(TR_11)); % version 1.7
              bidonbidonbidon=1; % version 1.7
          end % version 1.7
          if strcmpi(Remapping_CYC2(ii),TR_12_NEUTRE) % version 1.7
              fprintf(fid,'%s',char(TR_12)); % version 1.7
              bidonbidonbidon=1; % version 1.7
          end 
          if strcmpi(Remapping_CYC2(ii),TR_13_NEUTRE) % version 1.7
              fprintf(fid,'%s',char(TR_13)); % version 1.7
              bidonbidonbidon=1; % version 1.7
          end % version 1.7
          if bidonbidonbidon==0 % version 1.7
              fprintf(fid,'%s',char(Remapping_CYC2(ii))); % version 1.7
          end % version 1.7
          break
        end
    end
    fprintf(fid,'%c',';');
    fprintf(fid,'%u',compteur2(k,l));
    fprintf(fid,'%c',';');
    fprintf(fid,'%4.1f',minute2(k,l));
    fprintf(fid,'%c',';');
    fprintf(fid,'%4.2f',prix2(k,l));
    fprintf(fid,'%c',';');
    fprintf(fid,'%4.3f \n',prix2(k,l)/minute2(k,l));
    end
  end

  fprintf(fid,'%s',[char(CS_7),';;;;']);
  fprintf(fid,'%f \n',Prix_Total_Sans_Abonnement(k));
  fprintf(fid,'%s',[char(CS_8),';;;;']');
  fprintf(fid,'%f \n',Prix_Total(k));
  fprintf(fid,'\n');

if ~strcmp(Ranking(k),'N') & ~strcmp(Ranking(k),'No')  & ~strcmp(Ranking(k),'nO') & ~strcmp(Ranking(k),'no') & ~strcmp(Ranking(k),'NO') & ~strcmp(Ranking(k),'n')%V35G  %V35G
fprintf(fid,'%s \n',[char(TR_1),';',char(TR_2),';',char(TR_3)]);    
end
for m=1:max(size(etiquette))
  if flag_contest(m)==1    
     if prix(k,contest(m))~=0 
        if ~strcmp(Ranking(k),'N') & ~strcmp(Ranking(k),'No')  & ~strcmp(Ranking(k),'nO') & ~strcmp(Ranking(k),'no') & ~strcmp(Ranking(k),'NO') & ~strcmp(Ranking(k),'n')%V35G  %V35G
        % fprintf(fid,'%s',[char(label(contest(m))),';']); 
        bidonbidonbidon=0;
        if strcmpi(label(contest(m)),TR_4_NEUTRE) % version 1.7
        fprintf(fid,'%s',[char(TR_4),';']); 
        bidonbidonbidon=1;
        end
        if strcmpi(label(contest(m)),TR_5_NEUTRE) % version 1.7
        fprintf(fid,'%s',[char(TR_5),';']); 
        bidonbidonbidon=1;
        end
        if strcmpi(label(contest(m)),TR_6_NEUTRE) % version 1.7
        fprintf(fid,'%s',[char(TR_6),';']); 
        bidonbidonbidon=1;
        end
        if strcmpi(label(contest(m)),TR_7_NEUTRE) % version 1.7
        fprintf(fid,'%s',[char(TR_7),';']); 
        bidonbidonbidon=1;
        end
        if strcmpi(label(contest(m)),TR_8_NEUTRE) % version 1.7
        fprintf(fid,'%s',[char(TR_8),';']); 
        bidonbidonbidon=1;
        end
        if strcmpi(label(contest(m)),TR_9_NEUTRE) % version 1.7
        fprintf(fid,'%s',[char(TR_9),';']); 
        bidonbidonbidon=1;
        end
        if strcmpi(label(contest(m)),TR_10_NEUTRE) % version 1.7
        fprintf(fid,'%s',[char(TR_10),';']); 
        bidonbidonbidon=1;
        end
        if strcmpi(label(contest(m)),TR_11_NEUTRE) % version 1.7
        fprintf(fid,'%s',[char(TR_11),';']); 
        bidonbidonbidon=1;
        end
        if strcmpi(label(contest(m)),TR_12_NEUTRE) % version 1.7
        fprintf(fid,'%s',[char(TR_12),';']); 
        bidonbidonbidon=1;
        end
        if strcmpi(label(contest(m)),TR_13_NEUTRE) % version 1.7
        fprintf(fid,'%s',[char(TR_13),';']); 
        bidonbidonbidon=1;
        end
        if bidonbidonbidon==0
        fprintf(fid,'%s',[char(label(contest(m))),';']);    
        end
        fprintf(fid,'%u %c ',Rang_contest(m,k),';');
        fprintf(fid,' %4.1f  \n',prix_pour_le_calcul_du_ranking(k,contest(m))-mean(prix_pour_le_calcul_du_ranking(:,contest(m))));%V35G
        end      %V35G   
      end
  end
end


if strcmp(Ranking(k),'N') | strcmp(Ranking(k),'No') | strcmp(Ranking(k),'nO') | strcmp(Ranking(k),'no') | strcmp(Ranking(k),'NO') | strcmp(Ranking(k),'n')%V35G 
       fprintf(fid,'\n'); %V35G
       fprintf(fid,'%s','This number is   ; '); %V35G
       fprintf(fid,'%s \n','NotRanked'); %V35G
   
else
       fprintf(fid,'%s',[char(TR_14),';']);
       fprintf(fid,'%u %c',Rang_Prix_Total_pour_le_calcul_du_ranking(k),';');
       fprintf(fid,'%3.0f \n',(Prix_Total_pour_le_calcul_du_ranking(k)-mean(Prix_Total_pour_le_calcul_du_ranking(:))));
end

  %V168G: Carlo veut que le nombre de cartes actives affiché dans le
  %rapport individuel = le nombre de cartes pour lequel on a demandé un
  %ranking, pas le nombre de carte total.
  bidon=0; %V168G
  for m=1:max(size(Numero_Appelant))
       if ~strcmp(Ranking(m),'N') & ~strcmp(Ranking(m),'No') & ~strcmp(Ranking(m),'nO') & ~strcmp(Ranking(m),'no') & ~strcmp(Ranking(m),'NO') & ~strcmp(Ranking(m),'n')%V168G  
           bidon=bidon+1;%V168G
       end%V168G
  end%V168G
  if bidon~=max(size(Numero_Appelant))
    fprintf(fid,'%s  %u \n',[char(TR_15),';'],bidon);%V168G
  else
    fprintf(fid,'%s  %u \n',[char(TR_15),';'],max(size(Numero_Appelant)));%V168G
  end
% ---------------------------------------------------------------------
% SUR CHAQUE OVERVIEW INDIVIDUEL ON ECRIT TOUS LES COSTS PER USER
% POUR DES FINS D'HISTOGRAMME ET ON MET 'YOU ARE HERE' POUR LE RANGE DE
% l'USER DONT ON SAUVE LES RESULTATS SUR FICHIER
% ---------------------------------------------------------------------
    
compteur_per_range=zeros(31,1);
for l=1:29
    for m=1:max(size(Numero_Appelant))
        if ~strcmp(Ranking(m),'N') & ~strcmp(Ranking(m),'No')  & ~strcmp(Ranking(m),'nO') & ~strcmp(Ranking(m),'no') & ~strcmp(Ranking(m),'NO') & ~strcmp(Ranking(m),'n')%V168G    
        if ((l-1)*10<=Prix_Total_pour_histogramme(m)) & (l*10>Prix_Total_pour_histogramme(m))
            compteur_per_range(l)=compteur_per_range(l)+1;
        end
        end
    end
end
l=30;
for m=1:max(size(Numero_Appelant))
if ~strcmp(Ranking(m),'N') & ~strcmp(Ranking(m),'No')  & ~strcmp(Ranking(m),'nO') & ~strcmp(Ranking(m),'no') & ~strcmp(Ranking(m),'NO') & ~strcmp(Ranking(m),'n')%V168G          
if  ((l-1)*10<=Prix_Total_pour_histogramme(m))
    compteur_per_range(l)=compteur_per_range(l)+1;
end
end
end
for l=1:29
  if ((l-1)*10<=Prix_Total_pour_histogramme(k)) & (l*10>Prix_Total_pour_histogramme(k))
       if ~strcmp(Ranking(k),'N') & ~strcmp(Ranking(k),'No')  & ~strcmp(Ranking(k),'nO') & ~strcmp(Ranking(k),'no') & ~strcmp(Ranking(k),'NO') & ~strcmp(Ranking(k),'n')%V168G    
         fprintf(fid,'%s %c %f %s %f\n',char(HIST_4),';',compteur_per_range(l),';',compteur_per_range(l));
       else%V168G    
         fprintf(fid,'%s %c %f %s %f\n',char(HIST_4),';',compteur_per_range(l),';',compteur_per_range(l));%V168G    
       end%V168G  
  else
    fprintf(fid,'%4.2f %c %4.2f \n',(l-1)*10,';',compteur_per_range(l));
  end
end
l=30;
  if ((l-1)*10<=Prix_Total_pour_histogramme(k))
    if ~strcmp(Ranking(k),'N') & ~strcmp(Ranking(k),'No') & ~strcmp(Ranking(k),'nO') & ~strcmp(Ranking(k),'no') & ~strcmp(Ranking(k),'NO') & ~strcmp(Ranking(k),'n')%V168G   
      fprintf(fid,'%s %c %f %s %f\n','You are here',';',compteur_per_range(l),';',compteur_per_range(l));
    else%V168G    
      fprintf(fid,'%s %c %f %s %f\n','You would be here',';',compteur_per_range(l),';',compteur_per_range(l));%V168G    
    end%V168G  
  else
    fprintf(fid,'%4.2f %c %4.2f \n',l*10,';',compteur_per_range(l));
  end
fprintf(fid,'%4.2f %c %4.2f \n',l*100,';',0);

% ---------------------------------------------------------------------  
% SUR CHAQUE OVERVIEW INDIVIDUEL ON ECRIT TOUS LES COSTS PER USER
% POUR DES FINS D'HISTOGRAMME ET ON MET 'YOU ARE HERE' POUR LE RANGE DE
% l'USER DONT ON SAUVE LES RESULTATS SUR FICHIER
% ---------------------------------------------------------------------

  fprintf(fid,'%s \n',' ');
  fprintf(fid,'%s \n',char(CD_1));
  fprintf(fid,'%s \n',[char(CD_2),';',char(CD_3),';',char(CD_4),';',char(CD_5),';',char(CD_6),';',char(CD_7),';',char(CD_8)]);
  % --------------------------------
  % SAUVETAGE DES APPELS INDIVIDUELS
  % --------------------------------
  compteur_de_lignes_pour_sheet_Call_Details=0;
  for j=1:max(size(When_date_time))
    if strcmp(TRUE_OR_FALSE(j),'true') | strcmp(TRUE_OR_FALSE(j),'TRUE')
    if (strcmp(Line(j),Numero_Appelant(k)))
      for m=1:max(size(etiquette))
        if strcmp(char(Remapping_CYC2(j)),char(etiquette(m))) & ~strcmp(etiquette(m),'SUBSCRIPTION')
           bidonbidon=char(When_date_time(j));
           bidon=char(Destination_number(j));
           if isempty(bidon) bidon=['No Number']; end
           bidonbidonbidon=0;Remapping_CYC2_traduit=[]; %version 1.7
           if strcmpi(Remapping_CYC2(j),TR_4_NEUTRE) %version 1.7
              Remapping_CYC2_traduit=TR_4; %version 1.7
              bidonbidonbidon=1; %version 1.7
           end  %version 1.7
           if strcmpi(Remapping_CYC2(j),TR_5_NEUTRE) %version 1.7
              Remapping_CYC2_traduit=TR_5; %version 1.7
              bidonbidonbidon=1; %version 1.7
           end  %version 1.7
           if strcmpi(Remapping_CYC2(j),TR_6_NEUTRE) %version 1.7
              Remapping_CYC2_traduit=TR_6; %version 1.7
              bidonbidonbidon=1; %version 1.7
           end  %version 1.7
           if strcmpi(Remapping_CYC2(j),TR_7_NEUTRE) %version 1.7
              Remapping_CYC2_traduit=TR_7; %version 1.7
              bidonbidonbidon=1; %version 1.7
           end %version 1.7
           if strcmpi(Remapping_CYC2(j),TR_8_NEUTRE) %version 1.7
              Remapping_CYC2_traduit=TR_8; %version 1.7
              bidonbidonbidon=1; %version 1.7
           end  %version 1.7
           if strcmpi(Remapping_CYC2(j),TR_9_NEUTRE) %version 1.7
              Remapping_CYC2_traduit=TR_9; %version 1.7
              bidonbidonbidon=1; %version 1.7
           end  %version 1.7
           if strcmpi(Remapping_CYC2(j),TR_10_NEUTRE) %version 1.7
              Remapping_CYC2_traduit=TR_10; %version 1.7
              bidonbidonbidon=1; %version 1.7
           end %version 1.7
           if strcmpi(Remapping_CYC2(j),TR_11_NEUTRE) %version 1.7
              Remapping_CYC2_traduit=TR_11; %version 1.7
              bidonbidonbidon=1; %version 1.7
           end  %version 1.7
           if strcmpi(Remapping_CYC2(j),TR_12_NEUTRE) %version 1.7
              Remapping_CYC2_traduit=TR_12; %version 1.7
              bidonbidonbidon=1; %version 1.7
           end %version 1.7
           if strcmpi(Remapping_CYC2(j),TR_13_NEUTRE) %version 1.7
              Remapping_CYC2_traduit=TR_13; %version 1.7
              bidonbidonbidon=1; %version 1.7
           end %version 1.7
           if bidonbidonbidon==0 %version 1.7
           Remapping_CYC2_traduit=Remapping_CYC2(j); %version 1.7
           end %version 1.7
           if ~isempty(bidonbidon) % artifice pour le classement des calls details en fonction de dd/mm/yyyy - Excel importe toujourrs en mm/dd/yyyy
             fprintf(fid,'%s \n',[char(Remapping_CYC2_traduit),';',char(Renaming(j)),';',...
                                                              char(Destination_service(j)),'; ',char(When_date_time(j)),';',num2str([bidon(1:end)]),';',...
                                                              num2str(Consumption_count(j)),';',num2str(Amount_for_MUAC(j)),';',bidonbidon(1:2),';',bidonbidon(4:5),';',bidonbidon(9:10)]);
             compteur_de_lignes_pour_sheet_Call_Details=compteur_de_lignes_pour_sheet_Call_Details+1;
           else
             fprintf(fid,'%s \n',[char(Remapping_CYC2_traduit),';',char(Renaming(j)),';',...
                                                              char(Destination_service(j)),'; ',char(When_date_time(j)),';',num2str([bidon(1:end)]),';',...
                                                              num2str(Consumption_count(j)),';',num2str(Amount_for_MUAC(j)),';;;']);     
             compteur_de_lignes_pour_sheet_Call_Details=compteur_de_lignes_pour_sheet_Call_Details+1;            
           end    
        end  
      end            
    end
    end
  % --------------------------------
  % SAUVETAGE DES APPELS INDIVIDUELS
  % --------------------------------
  end
  fprintf(fid,' %s %c %4f','#Appels/Oproepen/Calls:',';',compteur_de_lignes_pour_sheet_Call_Details);
  fclose(fid);
end
end

%******************************************** 
% FIN SAUVETAGE TABLEAU PAR GSM  
%******************************************** 

set(handles.edit9,'String',['FIN EXECUTION:',datestr(now),'- DEBUT EXECUTATION:',debut_execution]);bidonbidon=[char(10),'FIN EXECUTION:',datestr(now),'- DEBUT EXECUTATION:',debut_execution];log_file_text=[log_file_text,bidonbidon];
drawnow;

%******************************************** 
% DEBUT SAUVETAGE TABLEAU POUR ACCOUNTING
%******************************************** 

nom_de_fichier=strcat([PathName,'\Overview_Log_File_',FileName])  
fid = fopen(nom_de_fichier,'wb');
fprintf(fid,'%s',log_file_text);
fclose(fid);
%******************************************** 
% FIN SAUVETAGE TABLEAU POUR ACCOUNTING
%******************************************** 


function update_compteur;
global compteur minute Consumption_count Amount_for_MUAC Amount_for_histogram CDR_Reconnu k l i prix prix_pour_histogramme prix_pour_MUAC
global compteur_par_Renaming minute_par_Renaming prix_par_Renaming
      compteur(k,l)=compteur(k,l)+1;
      minute(k,l)=minute(k,l)+Consumption_count(i);
      prix(k,l)=prix(k,l)+Amount_for_MUAC(i);
      prix_pour_histogramme(k,l)=prix_pour_histogramme(k,l)+Amount_for_histogram(i);
      prix_pour_MUAC(k,l)=prix_pour_MUAC(k,l)+Amount_for_MUAC(i);
      compteur_par_Renaming(l)=compteur_par_Renaming(l)+1;
      minute_par_Renaming(l)=minute_par_Renaming(l)+Consumption_count(i);
      prix_par_Renaming(l)=prix_par_Renaming(l)+Amount_for_MUAC(i);
      CDR_Reconnu=1;
      
function update_compteur2;
global compteur2 minute2 Consumption_count Amount_for_MUAC CDR_Reconnu k l i prix2
global compteur_par_Remapping_CYC2 minute_par_Remapping_CYC2 prix_par_Remapping_CYC2
      compteur2(k,l)=compteur2(k,l)+1;
      minute2(k,l)=minute2(k,l)+Consumption_count(i);
      prix2(k,l)=prix2(k,l)+Amount_for_MUAC(i);
      compteur_par_Remapping_CYC2(l)=compteur_par_Remapping_CYC2(l)+1;
      minute_par_Remapping_CYC2(l)=minute_par_Remapping_CYC2(l)+Consumption_count(i);
      prix_par_Remapping_CYC2(l)=prix_par_Remapping_CYC2(l)+Amount_for_MUAC(i);
      CDR_Reconnu=1;








% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

% Determine the selected data set.
global Client_Identification
global Client_ID

str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.

bidon=str{val};
for i=1:max(size(Client_ID{1}(:)))
if strcmp(bidon,Client_ID{1}(i))
Client_Identification=char(Client_ID{1}(i));
end
end




function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

 
        
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox10. 
function checkbox10_Callback(hObject, eventdata, handles)  % version 1.71
global no_display_of_histogram  % version 1.71
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10

if (get(hObject,'Value') == get(hObject,'Max'))  % version 1.71
	no_display_of_histogram=0;  % version 1.71
else  % version 1.71
	no_display_of_histogram=1;  % version 1.71
end  % version 1.71



% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
global no_generation_of_MUAC
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11

if (get(hObject,'Value') == get(hObject,'Max'))  % version 1.72
	no_generation_of_MUAC=0;  % version 1.72
else  % version 1.72
	no_generation_of_MUAC=1;  % version 1.72
end  % version 1.72





% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
global no_display_of_histogram
if get(hObject,'Value') == get(hObject,'Max')
    no_display_of_histogram=0; % toggle button is pressed
elseif get(hObject,'Value') == get(hObject,'Min')
    no_display_of_histogram=1; % toggle button is not pressed
end




% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
global no_generation_of_MUAC
if get(hObject,'Value') == get(hObject,'Max')
    no_generation_of_MUAC=1; % toggle button is pressed
elseif get(hObject,'Value') == get(hObject,'Min')
    no_generation_of_MUAC=0; % toggle button is not pressed
end

