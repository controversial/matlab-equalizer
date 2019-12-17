classdef gui < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure          matlab.ui.Figure
        GridLayout        matlab.ui.container.GridLayout
        LeftPanel         matlab.ui.container.Panel
        PlaybarSlider     matlab.ui.control.Slider
        PlayButton        matlab.ui.control.Button
        AttenSlider1Label matlab.ui.control.Label
        AttenSlider1      matlab.ui.control.Slider
        AttenSlider2Label matlab.ui.control.Label
        AttenSlider2      matlab.ui.control.Slider
        AttenSlider3Label matlab.ui.control.Label
        AttenSlider3      matlab.ui.control.Slider
        AttenSlider4Label matlab.ui.control.Label
        AttenSlider4      matlab.ui.control.Slider
        AttenSlider5Label matlab.ui.control.Label
        AttenSlider5      matlab.ui.control.Slider
        TitleLabel        matlab.ui.control.Label
        ChooseFileButton  matlab.ui.control.Button
        FilenameLabel     matlab.ui.control.Label
        RightPanel        matlab.ui.container.Panel
        UIAxes_1_1        matlab.ui.control.UIAxes
        UIAxes_2_1        matlab.ui.control.UIAxes
        UIAxes_1_2        matlab.ui.control.UIAxes
        UIAxes_2_2        matlab.ui.control.UIAxes
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
        inputFileAudio
        inputFileSampleRate
        attenuations = [1 1 1 1 1]
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, ~)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {382, 382};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {331, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 904 382];
            app.UIFigure.Name = 'UI Figure';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {331, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create PlaybarSlider
            app.PlaybarSlider = uislider(app.LeftPanel);
            app.PlaybarSlider.MajorTicks = [0 100];
            app.PlaybarSlider.MajorTickLabels = {'0:00', 'End', ''};
            app.PlaybarSlider.MinorTicks = [];
            app.PlaybarSlider.Position = [120 57 180 3];

            % Create PlayButton
            app.PlayButton = uibutton(app.LeftPanel, 'push');
            app.PlayButton.Position = [18 48 75 22];
            app.PlayButton.Text = {'Play'; ''};

            % Create AttenSlider1Label
            app.AttenSlider1Label = uilabel(app.LeftPanel);
            app.AttenSlider1Label.FontWeight = 'bold';
            app.AttenSlider1Label.Position = [18 126 53 22];
            app.AttenSlider1Label.Text = '1-199Hz';

            % Create AttenSlider1
            app.AttenSlider1 = uislider(app.LeftPanel);
            app.AttenSlider1.Limits = [0 2];
            app.AttenSlider1.MajorTicks = [0 1 2];
            app.AttenSlider1.Orientation = 'vertical';
            app.AttenSlider1.MinorTicks = [0 0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2];
            app.AttenSlider1.Position = [20 164 3 150];
            app.AttenSlider1.Value = 1;

            % Create AttenSlider2Label
            app.AttenSlider2Label = uilabel(app.LeftPanel);
            app.AttenSlider2Label.FontWeight = 'bold';
            app.AttenSlider2Label.Position = [82 126 50 22];
            app.AttenSlider2Label.Text = '200-499';

            % Create AttenSlider2
            app.AttenSlider2 = uislider(app.LeftPanel);
            app.AttenSlider2.Limits = [0 2];
            app.AttenSlider2.MajorTicks = [0 1 2];
            app.AttenSlider2.Orientation = 'vertical';
            app.AttenSlider2.MinorTicks = [0 0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2];
            app.AttenSlider2.Position = [84 164 3 150];
            app.AttenSlider2.Value = 1;

            % Create AttenSlider3Label
            app.AttenSlider3Label = uilabel(app.LeftPanel);
            app.AttenSlider3Label.FontWeight = 'bold';
            app.AttenSlider3Label.Position = [145 126 50 22];
            app.AttenSlider3Label.Text = '500-999';

            % Create AttenSlider3
            app.AttenSlider3 = uislider(app.LeftPanel);
            app.AttenSlider3.Limits = [0 2];
            app.AttenSlider3.MajorTicks = [0 1 2];
            app.AttenSlider3.Orientation = 'vertical';
            app.AttenSlider3.MinorTicks = [0 0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2];
            app.AttenSlider3.Position = [147 164 3 150];
            app.AttenSlider3.Value = 1;

            % Create AttenSlider4Label
            app.AttenSlider4Label = uilabel(app.LeftPanel);
            app.AttenSlider4Label.FontWeight = 'bold';
            app.AttenSlider4Label.Position = [207 126 51 22];
            app.AttenSlider4Label.Text = '1k-4999';

            % Create AttenSlider4
            app.AttenSlider4 = uislider(app.LeftPanel);
            app.AttenSlider4.Limits = [0 2];
            app.AttenSlider4.MajorTicks = [0 1 2];
            app.AttenSlider4.Orientation = 'vertical';
            app.AttenSlider4.MinorTicks = [0 0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2];
            app.AttenSlider4.Position = [209 164 3 150];
            app.AttenSlider4.Value = 1;

            % Create AttenSlider5Label
            app.AttenSlider5Label = uilabel(app.LeftPanel);
            app.AttenSlider5Label.FontWeight = 'bold';
            app.AttenSlider5Label.Position = [269 126 44 22];
            app.AttenSlider5Label.Text = '5k-20k';

            % Create AttenSlider5
            app.AttenSlider5 = uislider(app.LeftPanel);
            app.AttenSlider5.Limits = [0 2];
            app.AttenSlider5.MajorTicks = [0 1 2];
            app.AttenSlider5.Orientation = 'vertical';
            app.AttenSlider5.MinorTicks = [0 0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2];
            app.AttenSlider5.Position = [271 164 3 150];
            app.AttenSlider5.Value = 1;

            % Create TitleLabel
            app.TitleLabel = uilabel(app.LeftPanel);
            app.TitleLabel.FontSize = 14;
            app.TitleLabel.FontWeight = 'bold';
            app.TitleLabel.Position = [18 353 67 22];
            app.TitleLabel.Text = 'Equalizer';

            % Create ChooseFileButton
            app.ChooseFileButton = uibutton(app.LeftPanel, 'push');
            app.ChooseFileButton.Position = [232 353 78 22];
            app.ChooseFileButton.Text = 'Choose file';

            % Create FilenameLabel
            app.FilenameLabel = uilabel(app.LeftPanel);
            app.FilenameLabel.HorizontalAlignment = 'right';
            app.FilenameLabel.Position = [125 353 98 22];
            app.FilenameLabel.Text = 'No file selected';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create UIAxes_1_1
            app.UIAxes_1_1 = uiaxes(app.RightPanel);
            title(app.UIAxes_1_1, 'Initial Signal Waveform')
            xlabel(app.UIAxes_1_1, 'Sample #')
            ylabel(app.UIAxes_1_1, 'Amplitude')
            app.UIAxes_1_1.Position = [19 205 250 170];

            % Create UIAxes_2_1
            app.UIAxes_2_1 = uiaxes(app.RightPanel);
            title(app.UIAxes_2_1, 'Processed Signal Waveform')
            xlabel(app.UIAxes_2_1, 'Sample #')
            ylabel(app.UIAxes_2_1, 'Amplitude')
            app.UIAxes_2_1.Position = [19 24 250 170];

            % Create UIAxes_1_2
            app.UIAxes_1_2 = uiaxes(app.RightPanel);
            title(app.UIAxes_1_2, 'Initial Signal FFT')
            xlabel(app.UIAxes_1_2, 'Frequency')
            ylabel(app.UIAxes_1_2, 'Amplitude')
            app.UIAxes_1_2.XLim = [0 3000];
            app.UIAxes_1_2.XTick = [0 200 500 1000 2000 5000];
            app.UIAxes_1_2.XTickLabel = {'0'; '200'; '500'; '1000'; '2000'; '5000'};
            app.UIAxes_1_2.YTick = [0 1];
            app.UIAxes_1_2.Position = [300 205 250 170];

            % Create UIAxes_2_2
            app.UIAxes_2_2 = uiaxes(app.RightPanel);
            title(app.UIAxes_2_2, 'Processed Signal FFT')
            xlabel(app.UIAxes_2_2, 'Frequency')
            ylabel(app.UIAxes_2_2, 'Amplitude')
            app.UIAxes_2_2.XLim = [0 3000];
            app.UIAxes_2_2.XTick = [0 200 500 1000 2000 5000];
            app.UIAxes_2_2.XTickLabel = {'0'; '200'; '500'; '1000'; '2000'; '5000'};
            app.UIAxes_2_2.YTick = [0 1];
            app.UIAxes_2_2.Position = [300 24 250 170];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end

        % Implement app logic (NOT auto-generated)
        function bindComponents(app)
            app.ChooseFileButton.ButtonPushedFcn = @chooseFileCallback;
            app.AttenSlider1.ValueChangedFcn = @sliderChangedCallback;
            app.AttenSlider2.ValueChangedFcn = @sliderChangedCallback;
            app.AttenSlider3.ValueChangedFcn = @sliderChangedCallback;
            app.AttenSlider4.ValueChangedFcn = @sliderChangedCallback;
            app.AttenSlider5.ValueChangedFcn = @sliderChangedCallback;

            % The user presses chooseFileButton to pick a file
            function chooseFileCallback(~, ~)
                % Ask user to pick an audio file
                [file, path] = uigetfile({'*.mp3';'*.wav'});
                % Update the filename label
                app.FilenameLabel.Text=file;
                % Read audio file
                [audio, rate]=audioread(strcat(path, file));
                app.inputFileAudio = audio;
                app.inputFileSampleRate = rate;
                % Display waveform and FFT in plots
                audiofft = fft(audio, length(audio));
                audiofreqs = rate * (0:floor(length(audio)/2)) / length(audio);
                plot(app.UIAxes_1_1, (1:1:length(audio)), audio, '-r');
                plot(app.UIAxes_1_2, audiofreqs, abs(audiofft(1:floor(length(audio)/2+1))), '-r');
            end

            % The user moves one of the equalizer sliders to change the
            % settings
            function sliderChangedCallback(~, ~)
                app.attenuations = [
                    app.AttenSlider1.Value
                    app.AttenSlider2.Value
                    app.AttenSlider3.Value
                    app.AttenSlider4.Value
                    app.AttenSlider5.Value
                ];
                disp(app.attenuations);
            end
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = gui

            % Create UIFigure and components
            createComponents(app)

            % Set up bindings and logic
            bindComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end