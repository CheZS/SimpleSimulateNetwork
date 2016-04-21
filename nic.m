classdef nic
    properties
        buffer
        sendSpeed
    end
    methods
        function obj = nic()
            %% construction
            obj.buffer = zeros(8, 1);
            obj.sendSpeed = 1000 / 8;
        end
        function obj=send(obj)
            %% send the frame in buffer(1, 1)
            obj.buffer(1, 1) = max(0, obj.buffer(1, 1) - obj.sendSpeed);
            %% update obj.buffer
            i = 1;
            row = size(obj.buffer, 1);
            while (i < row && obj.buffer(i, 1) == 0)
                obj.buffer(i, 1) = obj.buffer(i + 1, 1);
                i = i + 1;
            end
            if (i > 1 && i <= row)
                obj.buffer(i, 1) = 0;
            end
        end
        function obj=receive(obj, frame)
            %% receive new frame
            insertPoint = 1;
            row = size(obj.buffer, 1);
            while (insertPoint <= row && obj.buffer(insertPoint, 1) > 0)
                insertPoint = insertPoint + 1;
            end
            if (insertPoint <= row)
                obj.buffer(insertPoint, 1) = frame;
            end
        end
    end
end