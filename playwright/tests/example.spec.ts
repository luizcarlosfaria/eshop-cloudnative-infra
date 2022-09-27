import { test, expect } from '@playwright/test';

const steps = 150;

test(`navigate to home ${steps} times`, async ({ page }) => {

  for (var i = 0; i < steps; i++) {
    await page.goto('http://localhost:90/');
  }

});

test(`navigate to camisa-selecao-brasileira-azul ${steps} times`, async ({ page }) => {

  for (var i = 0; i < steps; i++) {
    await page.goto('http://localhost:90/p/23/camisa-selecao-brasileira-azul');
  }

});

test(`navigate to camisa-selecao-brasileira-preta  ${steps} times`, async ({ page }) => {

  for (var i = 0; i < steps; i++) {
    await page.goto('http://localhost:90/p/24/camisa-selecao-brasileira-preta');
  }

});

test(`navigate to camisa-selecao-brasileira-amarela ${steps} times`, async ({ page }) => {

  for (var i = 0; i < steps; i++) {
    await page.goto('http://localhost:90/p/22/camisa-selecao-brasileira-amarela');
  }

});
