% EASYMATLABBOT  Interactive command-line chatbot powered by OpenAI GPT-5.5.
%
%   Starts a chat session in the MATLAB Command Window. The user can type
%   questions and receives responses from the language model.
%
%   Features:
%     - Model:          GPT-5.5 via openAIChat
%     - Word limit:     2000 words in conversation history (rolling window)
%     - Exit:           Type "end" or leave input empty
%     - Error handling: API errors are caught and displayed without crashing
%
%   Requirements:
%     - MATLAB R2025b or later
%     - MATLAB LLM Toolbox (openAIChat, messageHistory, generate, ...)
%     - OpenAI API key set as environment variable:
%         OPEN_API_KEY=your-api-key-here
%       On Windows:   setx OPEN_API_KEY "your-api-key-here"
%       On macOS/Linux: export OPEN_API_KEY="your-api-key-here"

function EasyMatlabBot()
% ... rest of the code
