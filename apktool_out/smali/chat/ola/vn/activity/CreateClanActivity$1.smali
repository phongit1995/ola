.class Lchat/ola/vn/activity/CreateClanActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/CreateClanActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/CreateClanActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/CreateClanActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$1;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 0

    const/4 p1, 0x6

    if-eq p2, p1, :cond_0

    if-eqz p3, :cond_1

    invoke-virtual {p3}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p1

    const/16 p2, 0x42

    if-ne p1, p2, :cond_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$1;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity;->a(Lchat/ola/vn/activity/CreateClanActivity;)V

    :cond_1
    const/4 p1, 0x0

    return p1
.end method
