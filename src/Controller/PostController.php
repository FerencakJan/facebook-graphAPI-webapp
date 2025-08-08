<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;

final class PostController extends AbstractController
{
    #[Route('/post', name: 'app_post')]
    public function index(): JsonResponse
    {
        return $this->json([
            'message' => 'Welcome to your new controller!',
            'path' => 'src/Controller/PostController.php',
        ]);
    }
    #[Route('/privacy', name: 'privacy_policy')]
    public function privacy(): Response
    {
         return new Response('<h1>Privacy Policy</h1><p>This is the privacy policy.</p>');
    }

    #[Route('/terms', name: 'terms_of_service')]
    public function terms(): Response
    {
        return new Response('<h1>Terms of Service</h1><p>These are the terms of service.</p>');
    }

    #[Route('/delete', name: 'data_deletion')]
    public function delete(): Response
    {
        return new Response('<h1>Data Deletion Instructions</h1><p>To delete your data, contact us at janik.ferencak3@gmail.com.</p>');
    }
}
