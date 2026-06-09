.class Lchat/ola/vn/m/m$a;
.super Lchat/ola/vn/util/http/WebAppInterfaceImp;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/m/m;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/m;


# direct methods
.method public constructor <init>(Lchat/ola/vn/m/m;Landroid/content/Context;Landroid/webkit/WebView;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/m$a;->a:Lchat/ola/vn/m/m;

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/util/http/WebAppInterfaceImp;-><init>(Landroid/content/Context;Landroid/webkit/WebView;)V

    return-void
.end method

.method static synthetic access$800(Lchat/ola/vn/m/m$a;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/m/m$a;->b:I

    return p0
.end method


# virtual methods
.method public getTopActionBarHeight(Ljava/lang/String;)I
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/m$a;->a:Lchat/ola/vn/m/m;

    invoke-static {v0}, Lchat/ola/vn/m/m;->c(Lchat/ola/vn/m/m;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    const/16 v1, 0x8

    if-ne v0, v1, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->b()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f070135

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/m/m$a;->b:I

    new-instance v0, Lchat/ola/vn/m/m$a$2;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/m/m$a$2;-><init>(Lchat/ola/vn/m/m$a;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    iget p1, p0, Lchat/ola/vn/m/m$a;->b:I

    return p1

    :cond_0
    invoke-super {p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->getTopActionBarHeight(Ljava/lang/String;)I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return p1
.end method

.method public onCloseApp()V
    .locals 2
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    invoke-super {p0}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->onCloseApp()V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/m$a;->a:Lchat/ola/vn/m/m;

    invoke-virtual {v0}, Lchat/ola/vn/m/m;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/m/m$a$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/m$a$3;-><init>(Lchat/ola/vn/m/m$a;)V

    invoke-virtual {v0, v1}, Landroid/support/v4/app/FragmentActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onVisibleActionBar(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/m/m$a$1;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/m/m$a$1;-><init>(Lchat/ola/vn/m/m$a;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
