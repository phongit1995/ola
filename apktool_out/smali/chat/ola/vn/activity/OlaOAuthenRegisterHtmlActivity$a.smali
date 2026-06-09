.class Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;
.super Lchat/ola/vn/util/http/WebAppInterfaceImp;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;


# direct methods
.method public constructor <init>(Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;Landroid/content/Context;Landroid/webkit/WebView;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;->a:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/util/http/WebAppInterfaceImp;-><init>(Landroid/content/Context;Landroid/webkit/WebView;)V

    return-void
.end method


# virtual methods
.method public onSignUpComplete(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    invoke-super {p0, p1, p2}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->onSignUpComplete(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;-><init>(Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method
