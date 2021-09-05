# JTweenService

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)

## General info
This Module is supposed to act like TweenService, but with more customization.

## Setup
```
local Instance : Instance = PATH_TO_INSTANCE;
local tweenInfo : table = {};
local Goals : table = {};

local Tween = JTweenService.new(Instance : Instance, tweenInfo : table, Goals : table) --// Making a tween;

Tween:Play();
```
