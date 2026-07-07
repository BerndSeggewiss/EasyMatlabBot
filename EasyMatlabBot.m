
function EasyMatlabBot()
    wordLimit = 2000;
    stopWord = "end";
    modelName = "gpt-5.5";
    chat = openAIChat( ...
        "You are a helpful assistant. Answer concisely.", ...
        ModelName=modelName);
    messages = messageHistory;
    totalWords = 0;
    messagesSizes = [];
    disp("=== Simple MATLAB ChatBot ===")
    disp("Type 'end' to exit.")
    disp("")
    running = true;
    while running
        query = input("User: ", "s");
        % leere Eingabe -> raus
        if isempty(query)
            disp("Empty input -> exiting.")
            break;
        end
        query = string(query);
        % Stop-Bedingung
        if strcmpi(query, stopWord)
            disp("AI: Closing the chat. Have a great day!")
            break;
        end
        % Wortanzahl User
        numWordsQuery = countNumWords(query);
        if numWordsQuery > wordLimit
            error("Your query has %d words (limit = %d)", ...
                  numWordsQuery, wordLimit);
        end
        % Historie aktualisieren
        messagesSizes = [messagesSizes; numWordsQuery];
        totalWords = totalWords + numWordsQuery;
        % Alte Messages entfernen
        while totalWords > wordLimit && ~isempty(messagesSizes)
            totalWords = totalWords - messagesSizes(1);
            messages = removeMessage(messages, 1);
            messagesSizes(1) = [];
        end
        % Anfrage hinzufügen
        messages = addUserMessage(messages, query);
        % ==== API CALL ====
        try
            [text, response] = generate(chat, messages);
        catch ME
            disp("ERROR during API call:")
            disp(ME.message)
            continue;
        end
        disp("AI: " + text)
        % Wortanzahl Antwort
        numWordsResponse = countNumWords(text);
        messagesSizes = [messagesSizes; numWordsResponse];
        totalWords = totalWords + numWordsResponse;
        % Antwort speichern
        messages = addResponseMessage(messages, response);
    end
end

% ==== Helper Function ====
function n = countNumWords(str)
    str = string(str);
    str = strip(str);
    if strlength(str) == 0
        n = 0;
        return;
    end
    words = split(str);
    words = words(strlength(words) > 0);
    n = numel(words);
end
