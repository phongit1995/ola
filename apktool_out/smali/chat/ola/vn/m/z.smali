.class public Lchat/ola/vn/m/z;
.super Lchat/ola/vn/m/a;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field private static a:Lchat/ola/vn/m/z;

.field private static b:Ljava/lang/String;


# instance fields
.field private final c:Ljava/lang/String;

.field private d:Landroid/webkit/WebView;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/m/a;-><init>()V

    const-string v0, "html/translate/view/"

    invoke-static {v0}, Lchat/ola/vn/util/http/a;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/m/z;->c:Ljava/lang/String;

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    sget-object v0, Lchat/ola/vn/m/z;->a:Lchat/ola/vn/m/z;

    if-nez v0, :cond_0

    sput-object p1, Lchat/ola/vn/m/z;->b:Ljava/lang/String;

    goto :goto_0

    :cond_0
    sget-object v0, Lchat/ola/vn/m/z;->a:Lchat/ola/vn/m/z;

    invoke-direct {v0, p1}, Lchat/ola/vn/m/z;->f(Ljava/lang/String;)V

    :goto_0
    const/4 p1, 0x5

    invoke-static {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/z;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/z;->f(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic d()Ljava/lang/String;
    .locals 1

    sget-object v0, Lchat/ola/vn/m/z;->b:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic e(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    sput-object p0, Lchat/ola/vn/m/z;->b:Ljava/lang/String;

    return-object p0
.end method

.method private f(Ljava/lang/String;)V
    .locals 4

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/z;->d:Landroid/webkit/WebView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "javascript:OLAPI.translate(\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\'"

    const-string v3, "\\\'"

    invoke-virtual {p1, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    const-string v2, "\n"

    const-string v3, " "

    invoke-virtual {p1, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "\')"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    :cond_0
    return-void
.end method


# virtual methods
.method public b(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->b(Landroid/os/Bundle;)V

    sput-object p0, Lchat/ola/vn/m/z;->a:Lchat/ola/vn/m/z;

    return-void
.end method

.method public c()I
    .locals 1

    const/4 v0, 0x5

    return v0
.end method

.method public h_()Landroid/app/Dialog;
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f04e8

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/z;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/m/z;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/m/z$2;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/m/z$2;-><init>(Lchat/ola/vn/m/z;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-object v1
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039f

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/z;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/z;->c()I

    move-result v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->d(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "SetJavaScriptEnabled"
        }
    .end annotation

    const/4 p2, 0x0

    const p3, 0x7f0b01d4

    invoke-virtual {p1, p3, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p3, 0x7f09039f

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    invoke-virtual {p3, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p3, 0x7f090613

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/webkit/WebView;

    iput-object p3, p0, Lchat/ola/vn/m/z;->d:Landroid/webkit/WebView;

    iget-object p3, p0, Lchat/ola/vn/m/z;->d:Landroid/webkit/WebView;

    invoke-virtual {p3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object p3

    const/4 v0, 0x1

    invoke-virtual {p3, v0}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    iget-object p3, p0, Lchat/ola/vn/m/z;->d:Landroid/webkit/WebView;

    invoke-virtual {p3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object p3

    invoke-virtual {p3, v0}, Landroid/webkit/WebSettings;->setNeedInitialFocus(Z)V

    const p3, 0x7f0903a0

    :try_start_0
    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/ImageView;

    const v1, 0x7f08079e

    invoke-virtual {p3, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    const p3, 0x7f09039a

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    const/16 v1, 0x8

    invoke-virtual {p3, v1}, Landroid/view/View;->setVisibility(I)V

    const p3, 0x7f0903a3

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/TextView;

    const v1, 0x7f0f00fa

    invoke-virtual {p3, v1}, Landroid/widget/TextView;->setText(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-virtual {p0}, Lchat/ola/vn/m/z;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p3

    if-eqz p3, :cond_0

    iget-object v1, p0, Lchat/ola/vn/m/z;->d:Landroid/webkit/WebView;

    new-instance v2, Lchat/ola/vn/util/http/WebAppInterfaceImp;

    iget-object v3, p0, Lchat/ola/vn/m/z;->d:Landroid/webkit/WebView;

    invoke-direct {v2, p3, v3}, Lchat/ola/vn/util/http/WebAppInterfaceImp;-><init>(Landroid/content/Context;Landroid/webkit/WebView;)V

    const-string p3, "OLAPK"

    invoke-virtual {v1, v2, p3}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    :cond_0
    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object p3

    iget-object v1, p0, Lchat/ola/vn/m/z;->c:Ljava/lang/String;

    invoke-static {p3, v1, p2, v0}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_1

    iget-object p3, p0, Lchat/ola/vn/m/z;->d:Landroid/webkit/WebView;

    invoke-virtual {p3, p2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/m/z;->d:Landroid/webkit/WebView;

    invoke-virtual {p2}, Landroid/webkit/WebView;->requestFocus()Z

    iget-object p2, p0, Lchat/ola/vn/m/z;->d:Landroid/webkit/WebView;

    new-instance p3, Lchat/ola/vn/m/z$1;

    invoke-direct {p3, p0}, Lchat/ola/vn/m/z$1;-><init>(Lchat/ola/vn/m/z;)V

    invoke-virtual {p2, p3}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    return-object p1
.end method

.method public onDetach()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/m/z;->a:Lchat/ola/vn/m/z;

    invoke-super {p0}, Lchat/ola/vn/m/a;->onDetach()V

    return-void
.end method

.method public onPause()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/m/a;->onPause()V

    return-void
.end method
