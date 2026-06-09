.class Lchat/ola/vn/activity/OlaBottomTabActivity$3;
.super Landroid/content/BroadcastReceiver;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBottomTabActivity;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaBottomTabActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBottomTabActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$3;->a:Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 5

    if-eqz p2, :cond_0

    :try_start_0
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_0

    const-string p2, "chat.ola.vn.ACTION_CHANGE_BALANCE"

    invoke-virtual {p2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$3;->a:Lchat/ola/vn/activity/OlaBottomTabActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$3;->a:Lchat/ola/vn/activity/OlaBottomTabActivity;

    const v0, 0x7f0f0181

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    sget-wide v3, Lchat/ola/vn/h;->o:J

    invoke-static {v3, v4}, Lchat/ola/vn/util/o;->a(J)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$3;->a:Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Lchat/ola/vn/activity/OlaBottomTabActivity;)Lchat/ola/vn/view/OlaTabViewLayout;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaTabViewLayout;->getCurrentFragmentTab()Landroid/support/v4/app/Fragment;

    move-result-object p1

    if-eqz p1, :cond_0

    instance-of p2, p1, Lchat/ola/vn/d/a;

    if-eqz p2, :cond_0

    check-cast p1, Lchat/ola/vn/d/a;

    sget-wide v0, Lchat/ola/vn/h;->o:J

    invoke-interface {p1, v0, v1}, Lchat/ola/vn/d/a;->a(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
