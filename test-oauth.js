#!/usr/bin/env node

/**
 * Test script to verify OAuth credentials loading
 */

console.log('=== OAuth Credentials Test ===');

// Check environment variables
console.log('Environment variables:');
console.log('GEMINI_OAUTH_CLIENT_ID:', process.env.GEMINI_OAUTH_CLIENT_ID ? 'SET' : 'NOT SET');
console.log('GEMINI_OAUTH_CLIENT_SECRET:', process.env.GEMINI_OAUTH_CLIENT_SECRET ? 'SET' : 'NOT SET');
console.log('GEMINI_OAUTH_CREDENTIALS_JSON:', process.env.GEMINI_OAUTH_CREDENTIALS_JSON ? 'SET' : 'NOT SET');

// Test the OAuth client creation
try {
  const { getOauthClient } = require('./packages/core/src/code_assist/oauth2.js');
  console.log('\nOAuth module loaded successfully');
  
  // Test creating the client (this will use the environment variables)
  console.log('\nTesting OAuth client creation...');
  const client = await getOauthClient();
  console.log('✅ OAuth client created successfully');
  
} catch (error) {
  console.error('❌ Error testing OAuth:', error.message);
  process.exit(1);
}

console.log('\n✅ OAuth credentials test completed successfully'); 