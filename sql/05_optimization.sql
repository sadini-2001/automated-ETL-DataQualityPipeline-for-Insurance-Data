-- Indexes for performance optimization
CREATE INDEX idx_policy_category ON master_policies(policy_category);
CREATE INDEX idx_start_date ON master_policies(start_date);
