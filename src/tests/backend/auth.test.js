const request = require('supertest');
const app = require('../../../backend/nodejs/server.js');
const { generateAuthToken } = require('../../../backend/controllers/auth_controller.js');

describe('Authentication System', () => {
  let testUser = {
    email: 'test@fieldmaster.com',
    password: 'SecurePass123!'
  };

  describe('User Registration', () => {
    it('should register new user with valid credentials', async () => {
      const res = await request(app)
        .post('/api/auth/register')
        .send(testUser);
      
      expect(res.statusCode).toEqual(201);
      expect(res.body).toHaveProperty('id');
      expect(res.body.email).toEqual(testUser.email);
    });

    it('should prevent duplicate registrations', async () => {
      const res = await request(app)
        .post('/api/auth/register')
        .send(testUser);
      
      expect(res.statusCode).toEqual(400);
      expect(res.body).toHaveProperty('error');
    });
  });

  describe('User Login', () => {
    it('should authenticate valid credentials', async () => {
      const res = await request(app)
        .post('/api/auth/login')
        .send(testUser);
      
      expect(res.statusCode).toEqual(200);
      expect(res.body).toHaveProperty('token');
    });

    it('should reject invalid credentials', async () => {
      const res = await request(app)
        .post('/api/auth/login')
        .send({...testUser, password: 'WrongPassword'});
      
      expect(res.statusCode).toEqual(401);
      expect(res.body).toHaveProperty('error');
    });
  });

  describe('Token Verification', () => {
    let authToken;

    beforeAll(async () => {
      const loginRes = await request(app)
        .post('/api/auth/login')
        .send(testUser);
      authToken = loginRes.body.token;
    });

    it('should validate legitimate tokens', async () => {
      const res = await request(app)
        .get('/api/auth/verify')
        .set('Authorization', `Bearer ${authToken}`);
      
      expect(res.statusCode).toEqual(200);
      expect(res.body).toHaveProperty('valid', true);
    });

    it('should reject invalid tokens', async () => {
      const res = await request(app)
        .get('/api/auth/verify')
        .set('Authorization', 'Bearer invalid.token.here');
      
      expect(res.statusCode).toEqual(401);
      expect(res.body).toHaveProperty('error');
    });
  });
});