.class public Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;
.super Landroid/app/Activity;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;
    }
.end annotation


# instance fields
.field private a:Landroid/webkit/WebView;

.field private b:Landroid/widget/ProgressBar;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;)Landroid/widget/ProgressBar;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->b:Landroid/widget/ProgressBar;

    return-object p0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09009f

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->finish()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "SetJavaScriptEnabled"
        }
    .end annotation

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0198

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->setContentView(I)V

    const p1, 0x7f09009f

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903e9

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ProgressBar;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->b:Landroid/widget/ProgressBar;

    const p1, 0x7f090613

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/webkit/WebView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->a:Landroid/webkit/WebView;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->a:Landroid/webkit/WebView;

    invoke-virtual {p1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object p1

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->a:Landroid/webkit/WebView;

    invoke-virtual {p1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setNeedInitialFocus(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->a:Landroid/webkit/WebView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->setScrollBarStyle(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->a:Landroid/webkit/WebView;

    invoke-virtual {p1}, Landroid/webkit/WebView;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->a:Landroid/webkit/WebView;

    new-instance v1, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$1;-><init>(Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;)V

    invoke-virtual {p1, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->a:Landroid/webkit/WebView;

    new-instance v1, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->a:Landroid/webkit/WebView;

    invoke-direct {v1, p0, p0, v2}, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;-><init>(Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;Landroid/content/Context;Landroid/webkit/WebView;)V

    const-string v2, "OLAPK"

    invoke-virtual {p1, v1, v2}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    const-string p1, "id/signup"

    const/4 v1, 0x0

    invoke-static {v1, p1, v1, v0}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->a:Landroid/webkit/WebView;

    invoke-virtual {v0, p1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method protected onDestroy()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->a:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->stopLoading()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    return-void
.end method
