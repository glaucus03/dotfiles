-- 基本設定の初期化
local function init_base()
  vim.opt.fileencoding = 'utf-8'
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  local vars = {
    python_host_prog = '/usr/bin/python2',
    python3_host_prog = '/usr/bin/python3',
    loaded_matchparen = 1,
    vimsyn_embed = 1,
    loaded_python_provider = 0,
    loaded_perl_provider = 0,
    loaded_ruby_provider = 0,
    loaded_rrhelper = 1,
    loaded_vimball = 1,
    loaded_vimballPlugin = 1,
    loaded_getscript = 1,
    loaded_getscriptPlugin = 1,
    loaded_logipat = 1,
    loaded_man = 1,
  }

  for var, val in pairs(vars) do
    vim.g[var] = val
  end
end

-- 環境依存の設定初期化
local function init_env_specific()
  if vim.fn.getenv('DENO_PATH') then
    vim.g["denops#deno"] = vim.fn.getenv('DENO_PATH')
  end
end

-- プロジェクト固有設定の読み込み
local function load_local_config()
  local local_vimrc = vim.fn.getcwd() .. '/.nvim.lua'
  if vim.fn.filereadable(local_vimrc) == 1 then
    dofile(local_vimrc)
  end
end

-- 初期化の実行
init_base()
init_env_specific()

-- core モジュールの読み込み
require('core.env')
require('core.options')
require('core.keys')
require('core.commands')

-- プラグイン関連の初期化
require("plugins")

-- ローカル設定の読み込み
load_local_config()
