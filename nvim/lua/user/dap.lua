local status_ok, dap = pcall(require, "dap-python")
if not status_ok then
	return
end

local status_dapui, dapui = pcall(require, "dapui")
if not status_dapui then
	return
end

dapui.setup()

local function dap_python()
	local venv = os.getenv("VIRTUAL_ENV") .. "/bin/python"
	return venv
end

local status, venv = pcall(dap_python)
if status then
	dap.setup(venv)
end
