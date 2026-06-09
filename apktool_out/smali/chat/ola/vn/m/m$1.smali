.class Lchat/ola/vn/m/m$1;
.super Landroid/webkit/WebViewClient;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/m;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/m;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/m;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method


# virtual methods
.method public onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-static {v0, p2}, Lchat/ola/vn/m/m;->d(Lchat/ola/vn/m/m;Ljava/lang/String;)Ljava/lang/String;

    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-static {p1}, Lchat/ola/vn/m/m;->a(Lchat/ola/vn/m/m;)Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-static {p1, p2}, Lchat/ola/vn/m/m;->c(Lchat/ola/vn/m/m;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 2

    :try_start_0
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, p2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URL;->getHost()Ljava/lang/String;

    move-result-object v0

    const-string v1, "ola.vn"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, ".ola.vn"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v0, :cond_0

    :try_start_1
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, p2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URL;->getHost()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-virtual {v1, v0}, Lchat/ola/vn/m/m;->e(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    :cond_0
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-static {v0}, Lchat/ola/vn/m/m;->a(Lchat/ola/vn/m/m;)Landroid/view/View;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-static {v0, p2}, Lchat/ola/vn/m/m;->a(Lchat/ola/vn/m/m;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-virtual {p1}, Lchat/ola/vn/m/m;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1, p2}, Lchat/ola/vn/util/b;->m(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-static {p1}, Lchat/ola/vn/m/m;->b(Lchat/ola/vn/m/m;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-static {v0, p2}, Lchat/ola/vn/m/m;->b(Lchat/ola/vn/m/m;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object p1, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-static {p1}, Lchat/ola/vn/m/m;->b(Lchat/ola/vn/m/m;)V

    return-void

    :cond_2
    invoke-super {p0, p1, p2, p3}, Landroid/webkit/WebViewClient;->onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V

    iget-object p1, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-static {p1, p2}, Lchat/ola/vn/m/m;->c(Lchat/ola/vn/m/m;Ljava/lang/String;)V

    return-void
.end method

.method public onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    .locals 6

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-virtual {p1}, Lchat/ola/vn/m/m;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f009b

    const v2, 0x7f0f03ac

    const v3, 0x7f0f05e3

    const v4, 0x7f0f0480

    new-instance v5, Lchat/ola/vn/m/m$1$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/m/m$1$1;-><init>(Lchat/ola/vn/m/m$1;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    iget-object p1, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-static {p1}, Lchat/ola/vn/m/m;->a(Lchat/ola/vn/m/m;)Landroid/view/View;

    move-result-object p1

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    :try_start_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 4

    :try_start_0
    invoke-virtual {p2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "http"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-static {p2}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v0

    const/4 v3, 0x0

    invoke-static {v0, p2, v3, v2}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    return v2

    :cond_0
    return v1

    :cond_1
    invoke-static {p2}, Lchat/ola/vn/util/m;->g(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    iget-object v1, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-virtual {v1}, Lchat/ola/vn/m/m;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v1, v0}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    return v2

    :cond_2
    invoke-static {p2}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v3, :cond_3

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/m/m$1;->a:Lchat/ola/vn/m/m;

    invoke-virtual {p1}, Lchat/ola/vn/m/m;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1, v0, v1, v1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    return v2

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z

    move-result p1

    return p1
.end method
