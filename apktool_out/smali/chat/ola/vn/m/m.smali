.class public Lchat/ola/vn/m/m;
.super Lchat/ola/vn/m/a;

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
        Lchat/ola/vn/m/m$a;
    }
.end annotation


# static fields
.field private static a:Ljava/lang/String; = null

.field private static b:Ljava/lang/String; = ""

.field private static o:Lchat/ola/vn/m/m;


# instance fields
.field private c:Ljava/lang/String;

.field private d:Landroid/webkit/WebView;

.field private e:Landroid/widget/TextView;

.field private f:Landroid/view/View;

.field private g:Landroid/widget/ImageView;

.field private h:Landroid/view/View;

.field private i:Landroid/view/View;

.field private j:Lchat/ola/vn/view/OlaCachedImageView;

.field private k:Landroid/view/View;

.field private l:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/m/a;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/m/m;->c:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/m/m;->l:Z

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/m;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/m;->f:Landroid/view/View;

    return-object p0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-object v0, Lchat/ola/vn/m/m;->o:Lchat/ola/vn/m/m;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/m/m;->o:Lchat/ola/vn/m/m;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/m/m;->f(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    sput-object p2, Lchat/ola/vn/m/m;->b:Ljava/lang/String;

    if-nez p2, :cond_1

    const-string p2, ""

    sput-object p2, Lchat/ola/vn/m/m;->b:Ljava/lang/String;

    :cond_1
    sput-object p1, Lchat/ola/vn/m/m;->a:Ljava/lang/String;

    :goto_0
    const/16 p1, 0x8

    invoke-static {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/m;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/m;->a(Z)V

    return-void
.end method

.method private a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V
    .locals 3

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaCachedImageView;->getWidth()I

    move-result v1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaCachedImageView;->getPaddingLeft()I

    move-result v2

    sub-int/2addr v1, v2

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaCachedImageView;->getPaddingRight()I

    move-result v2

    sub-int/2addr v1, v2

    add-int/lit8 v1, v1, -0x14

    invoke-virtual {v0, p2, p1, v1}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    return-void
.end method

.method private a(Z)V
    .locals 3

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/m;->i:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {p1}, Landroid/webkit/WebView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    check-cast p1, Landroid/widget/FrameLayout$LayoutParams;

    invoke-virtual {p0}, Lchat/ola/vn/m/m;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f07014a

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    iput v1, p1, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I

    iget-object v1, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {v1, p1}, Landroid/webkit/WebView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object p1, p0, Lchat/ola/vn/m/m;->i:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/m;->i:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result p1

    const/16 v1, 0x8

    if-eq p1, v1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {p1}, Landroid/webkit/WebView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    check-cast p1, Landroid/widget/FrameLayout$LayoutParams;

    iput v0, p1, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I

    iget-object v0, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {v0, p1}, Landroid/webkit/WebView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object p1, p0, Lchat/ola/vn/m/m;->i:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/m;Ljava/lang/String;)Z
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/m;->g(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method static synthetic b(Lchat/ola/vn/m/m;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/m;->d()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/m/m;Ljava/lang/String;)Z
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/m;->f(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/m/m;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/m;->i:Landroid/view/View;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/m/m;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/m;->h(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/m/m;)Landroid/webkit/WebView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/m/m;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/m;->c:Ljava/lang/String;

    return-object p1
.end method

.method private d()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->stopLoading()V

    invoke-direct {p0}, Lchat/ola/vn/m/m;->e()V

    iget-object v0, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->clearHistory()V

    invoke-virtual {p0}, Lchat/ola/vn/m/m;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->i()V

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/m;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/m/m;->c()I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->d(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private e()V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0x12
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->clearView()V

    iget-object v0, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->clearHistory()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private f(Ljava/lang/String;)Z
    .locals 1

    :try_start_0
    const-string v0, "http://mobile.ola.vn/"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method private g(Ljava/lang/String;)Z
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "https://play.google.com/store/apps"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    const-string v0, "play.google.com/store/apps"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p1, :cond_1

    :cond_0
    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method private h(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->i(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->canGoBack()Z

    move-result v0

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/m;->k:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/m;->k:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_6

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/m/m;->l:Z

    iget-object v0, p0, Lchat/ola/vn/m/m;->h:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    const-string v0, "note"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/m;->g:Landroid/widget/ImageView;

    const v3, 0x7f080633

    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/m/m;->g:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/m/m;->g:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/m;->h:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    const v1, 0x7f080798

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_1
    const-string v0, "osimi"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f08079a

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/m/m;->g:Landroid/widget/ImageView;

    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void

    :cond_2
    const-string v0, "hrsc"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f08006a

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    goto :goto_1

    :cond_3
    const-string v0, "adme"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f080068

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_1

    :cond_4
    :try_start_1
    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v0, p1}, Lchat/ola/vn/r/a/c;->a(Ljava/lang/String;)Lchat/ola/vn/entry/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entry/e;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_5

    iget-object v3, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/entry/e;->b()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v3, v0}, Lchat/ola/vn/m/m;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f080818

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    :cond_5
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    goto :goto_1

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/m;->g:Landroid/widget/ImageView;

    invoke-virtual {p1, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/m;->g:Landroid/widget/ImageView;

    const v0, 0x7f08064d

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/m/m;->k:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iput-boolean v2, p0, Lchat/ola/vn/m/m;->l:Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method private i(Ljava/lang/String;)Z
    .locals 1

    :try_start_0
    const-string v0, "mall"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "adme"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p1, :cond_1

    :cond_0
    const/4 p1, 0x0

    return p1

    :catch_0
    :cond_1
    const/4 p1, 0x1

    return p1
.end method

.method private j(Ljava/lang/String;)V
    .locals 0

    return-void
.end method


# virtual methods
.method public b(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->b(Landroid/os/Bundle;)V

    sput-object p0, Lchat/ola/vn/m/m;->o:Lchat/ola/vn/m/m;

    sget-object p1, Lchat/ola/vn/m/m;->a:Ljava/lang/String;

    sget-object v0, Lchat/ola/vn/m/m;->b:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/m/m;->f(Ljava/lang/String;Ljava/lang/String;)V

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lchat/ola/vn/m/m;->setHasOptionsMenu(Z)V

    return-void
.end method

.method public c()I
    .locals 1

    const/16 v0, 0x8

    return v0
.end method

.method public e(Ljava/lang/String;)V
    .locals 1

    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/m;->e:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/m/m;->e:Landroid/widget/TextView;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/m;->e:Landroid/widget/TextView;

    const/16 v0, 0x8

    goto :goto_0

    return-void
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/m/a;->e_()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0}, Lchat/ola/vn/m/m;->e()V

    sput-object p1, Lchat/ola/vn/m/m;->a:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/m/m;->a:Ljava/lang/String;

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-static {v0, v1, v2, v3}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/m/m;->a:Ljava/lang/String;

    invoke-static {v0, v1, v2, v3}, Lchat/ola/vn/util/http/a;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-direct {p0, p1}, Lchat/ola/vn/m/m;->i(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-direct {p0, v3}, Lchat/ola/vn/m/m;->a(Z)V

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/m;->a(Z)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {p1}, Landroid/webkit/WebView;->clearHistory()V

    iget-object p1, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    invoke-virtual {p0, p2}, Lchat/ola/vn/m/m;->e(Ljava/lang/String;)V

    :cond_2
    return-void
.end method

.method public g_()Z
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->canGoBack()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->goBack()V

    const/4 v0, 0x1

    return v0

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/m/m;->d()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    const/4 v0, 0x0

    return v0
.end method

.method public h_()Landroid/app/Dialog;
    .locals 3

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f04e8

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/m;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/m/m;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/m/m$2;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/m/m$2;-><init>(Lchat/ola/vn/m/m;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f0901f0

    if-eq v0, v1, :cond_4

    const v1, 0x7f09039a

    if-eq v0, v1, :cond_3

    const v1, 0x7f09039d

    if-eq v0, v1, :cond_1

    const p1, 0x7f09039f

    if-eq v0, p1, :cond_0

    return-void

    :cond_0
    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/m/m;->d()V

    return-void

    :cond_1
    iget-boolean v0, p0, Lchat/ola/vn/m/m;->l:Z

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-direct {p0, p1}, Lchat/ola/vn/m/m;->j(Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/m/m;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_5

    new-instance p1, Landroid/content/Intent;

    const-string v0, "android.intent.action.VIEW"

    iget-object v1, p0, Lchat/ola/vn/m/m;->c:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/http/c;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    invoke-virtual {p0, p1}, Lchat/ola/vn/m/m;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/m/m;->g_()Z

    return-void

    :cond_4
    invoke-virtual {p0}, Lchat/ola/vn/m/m;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/note/OlaNoteComposerActivity;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_5
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "SetJavaScriptEnabled"
        }
    .end annotation

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object p3

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/m/m;->d()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :catch_0
    :cond_0
    const p2, 0x7f0b01d4

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f09039f

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    const p3, 0x7f080640

    invoke-virtual {p2, p3}, Landroid/widget/ImageView;->setImageResource(I)V

    const/4 p3, 0x0

    invoke-virtual {p2, p3}, Landroid/widget/ImageView;->setVisibility(I)V

    invoke-virtual {p2, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090306

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/m;->i:Landroid/view/View;

    const p2, 0x7f0903a3

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/m/m;->e:Landroid/widget/TextView;

    const p2, 0x7f0903a0

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p2, p0, Lchat/ola/vn/m/m;->j:Lchat/ola/vn/view/OlaCachedImageView;

    const p2, 0x7f09039a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/m;->k:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/m/m;->k:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f0903e9

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/m;->f:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/m/m;->f:Landroid/view/View;

    invoke-virtual {p2, p3}, Landroid/view/View;->setVisibility(I)V

    const p2, 0x7f090613

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/webkit/WebView;

    iput-object p2, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    iget-object p2, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {p2}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object p2

    const/4 p3, 0x1

    invoke-virtual {p2, p3}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    iget-object p2, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {p2}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object p2

    invoke-virtual {p2, p3}, Landroid/webkit/WebSettings;->setNeedInitialFocus(Z)V

    const p2, 0x7f0901f0

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/m;->h:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/m/m;->h:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09039d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/m/m;->g:Landroid/widget/ImageView;

    iget-object p2, p0, Lchat/ola/vn/m/m;->g:Landroid/widget/ImageView;

    invoke-virtual {p2, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {p2}, Landroid/webkit/WebView;->requestFocus()Z

    iget-object p2, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {p2}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object p2

    invoke-virtual {p2, p3}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    iget-object p2, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    new-instance p3, Lchat/ola/vn/m/m$1;

    invoke-direct {p3, p0}, Lchat/ola/vn/m/m$1;-><init>(Lchat/ola/vn/m/m;)V

    invoke-virtual {p2, p3}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/m;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p2

    if-eqz p2, :cond_1

    iget-object p3, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    new-instance v0, Lchat/ola/vn/m/m$a;

    iget-object v1, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-direct {v0, p0, p2, v1}, Lchat/ola/vn/m/m$a;-><init>(Lchat/ola/vn/m/m;Landroid/content/Context;Landroid/webkit/WebView;)V

    const-string p2, "OLAPK"

    invoke-virtual {p3, v0, p2}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    :cond_1
    return-object p1
.end method

.method public onDestroy()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/m/m;->o:Lchat/ola/vn/m/m;

    invoke-super {p0}, Lchat/ola/vn/m/a;->onDestroy()V

    return-void
.end method

.method public onDetach()V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/m/m;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->i()V

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/m/a;->onDetach()V

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/m/m;->o:Lchat/ola/vn/m/m;

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/m/m;->e()V

    iget-object v0, p0, Lchat/ola/vn/m/m;->d:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->clearHistory()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
