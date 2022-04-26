ALTER TABLE Agent ADD HouseRepresented NUMBER DEFAULT 0;
-- Trigger 1--
CREATE OR REPLACE TRIGGER AgentBook
BEFORE INSERT ON Agent
FOR EACH ROW
DECLARE
houseRep integer;
BEGIN
    SELECT HouseRepresented INTO houseRep FROM Agent WHERE AgentId = :new.AgentId;
    IF houseRep = 3 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Agent is fully booked!');
    END IF;
    IF houseRep < 3 THEN
        UPDATE AGENT
        SET HouseRepresented = HouseRepresented + 1
        WHERE AgentID = :new.AgentID;
    END IF;
END;
/

--Trigger 2--

CREATE OR REPLACE TRIGGER agentDelete
AFTER DELETE ON AGENT
FOR EACH ROW
BEGIN
    UPDATE AGENT
    SET HouseRepresented = HouseRepresented - 1
    WHERE AgentID = :old.AgentID;
END;

-- Trigger 3--

CREATE OR REPLACE TRIGGER agentAlter
AFTER UPDATE OF AgentID ON Agent
FOR EACH ROW
DECLARE 
houseRep integer;
BEGIN
    SELECT HouseRepresented INTO houseRep FROM Agent WHERE AgentID = :new.AgentID;
    IF houseRep = 3 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Agent is booked!');
    END IF;
    IF houseRep < 3 THEN
        UPDATE AGENT
        SET HouseRepresented = HouseRepresented - 1
        WHERE AgentID = :old.AgentID;
        
        UPDATE Agent
        SET HouseRepresented = HouseRepresented + 1
        WHERE AgentID = :new.AgentID;
    END IF;
END;




