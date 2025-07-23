CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Todo Lists table
CREATE TABLE todo_lists (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Todo Groups table (optional grouping within lists)
CREATE TABLE todo_groups (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    todo_list_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_todo_groups_list FOREIGN KEY (todo_list_id) REFERENCES todo_lists(id) ON DELETE CASCADE
);

-- Todos table
CREATE TABLE todos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    completed BOOLEAN DEFAULT FALSE,
    todo_list_id UUID NOT NULL,
    todo_group_id UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_todos_list FOREIGN KEY (todo_list_id) REFERENCES todo_lists(id) ON DELETE CASCADE,
    CONSTRAINT fk_todos_group FOREIGN KEY (todo_group_id) REFERENCES todo_groups(id) ON DELETE SET NULL
);

-- Subtasks table
CREATE TABLE subtasks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    completed BOOLEAN DEFAULT FALSE,
    todo_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_subtasks_todo FOREIGN KEY (todo_id) REFERENCES todos(id) ON DELETE CASCADE
);

-- Create indexes for better query performance
CREATE INDEX idx_todo_groups_list_id ON todo_groups(todo_list_id);
CREATE INDEX idx_todos_list_id ON todos(todo_list_id);
CREATE INDEX idx_todos_group_id ON todos(todo_group_id);
CREATE INDEX idx_todos_completed ON todos(completed);
CREATE INDEX idx_subtasks_todo_id ON subtasks(todo_id);
CREATE INDEX idx_subtasks_completed ON subtasks(completed);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply updated_at triggers to all tables
CREATE TRIGGER update_todo_lists_updated_at 
    BEFORE UPDATE ON todo_lists 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_todo_groups_updated_at 
    BEFORE UPDATE ON todo_groups 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_todos_updated_at 
    BEFORE UPDATE ON todos 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_subtasks_updated_at 
    BEFORE UPDATE ON subtasks 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

