local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local status_ok, dap_python = pcall(require, "dap-python")
if not status_ok then
	return
end

local status_dapui, dapui = pcall(require, "dapui")
if not status_dapui then
	return
end

dapui.setup()

local function dappython()
	local venv = os.getenv("VIRTUAL_ENV") .. "/bin/python"
	return venv
end

local status, venv = pcall(dappython)
if status then
	dap_python.setup(venv)
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end
