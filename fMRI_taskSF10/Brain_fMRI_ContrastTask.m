
function Brain_fMRI_ContrastTask

% Participant = get demographic data and contrast values obtained in
% pshychophisical task for each participant.
Participant=GetInformationParticipant;

% get the conditions for each participant
[conditionsV] = getConditions(Participant);

% Ask for the fMRI PROTOCOL experiment and choose a RUN
[filename, pathname] = uigetfile( {'*.lospp','LoSpP Protocol (*.lospp)';},'Open Protocol','Protocols/');

% If you did not choose a fMRI PROTOCOL file for the EVENT-RELATED
% experiment returns an error
if ( ~ischar(pathname) || ~ischar(filename) )
    errordlg('You must choose a file!','Error','modal');
    return
end

% Build the complete path for the file and load the experiment parameters
completepath = strcat(pathname,filename);
load(completepath,'-mat','chaos','nrepeats','tr','tr_factor');

% Define the protocol name to use from now
protocolName = filename(1:end-6);

% Create the complete protocol with the subject-specific speed values
[StimuliPrt] = CreateProtocol(chaos,nrepeats,tr,tr_factor,protocolName,conditionsV,Participant);

% Create text box with summary information about the experiment and wait
% for mouse click to continue the program and enter the experiment
text = [protocolName,'protocolName |',num2str(StimuliPrt.timecourse.total_volumes),' vols | ',num2str(StimuliPrt.timecourse.total_time),' secs'];
uiwait(msgbox(text,'Brain_fMRI_ContrastTask','modal'))

% Run EVENTS experiment and return 'logdata' with responses
[logdata] = Load_Protocol(StimuliPrt.events, StimuliPrt.parameters);

% Asks for saving the data
saveData(Participant, StimuliPrt,logdata, protocolName);


% Function thas prompts for saving 'logdata'
function saveData(Participant, StimuliPrt,logdata, protocolName)


% Asks for filename and folder to save 'logdata'

[filename, pathname] = uiputfile( {'*.lolog','LoSP/P Participant (*.lolog)';},'Save Participant',strcat('Output/',num2str(Participant.Information.ID),'/',num2str(Participant.Information.ID),'_LOG_',protocolName,'_',datestr(now,'HHMM_ddmmyy')));

if ( ischar(pathname) || ischar(filename) )
    completepath = strcat(pathname,filename);
    save(completepath,'Participant','StimuliPrt','logdata')
   
else
    % if the user does not choose a valid filename or folder it warns
    % him/her and asks if the user really wants to exit without saving the
    % data
    exitEvents = questdlg('You did not save the data. Do you want to save it before exit?','Attention','Yes','No','No');
    switch exitEvents
        case 'Yes'
            % Ask for saving data again
            saveData(Participant, StimuliPrt,logdata, protocolName)

        
        case 'No'
            % Exit the EVENTS experiment without saving 'logdata'
            errordlg('You did not save the data!','Error','modal');
            return
    end
end

end


end

