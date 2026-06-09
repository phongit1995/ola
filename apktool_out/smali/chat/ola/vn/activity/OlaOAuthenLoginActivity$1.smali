.class Lchat/ola/vn/activity/OlaOAuthenLoginActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaOAuthenLoginActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$1;->a:Lchat/ola/vn/activity/OlaOAuthenLoginActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 0

    const p1, 0x7f0900dd

    if-eq p2, p1, :cond_1

    if-nez p2, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    return p1

    :cond_1
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$1;->a:Lchat/ola/vn/activity/OlaOAuthenLoginActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;)V

    const/4 p1, 0x1

    return p1
.end method
