.class Lchat/ola/vn/activity/OlaAppSettingActivity$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnDismissListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaAppSettingActivity;->D()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaAppSettingActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaAppSettingActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$5;->a:Lchat/ola/vn/activity/OlaAppSettingActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$5;->a:Lchat/ola/vn/activity/OlaAppSettingActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->c(Lchat/ola/vn/activity/OlaAppSettingActivity;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    sget v0, Lchat/ola/vn/c/x;->i:I

    invoke-virtual {p1, v0}, Lchat/ola/vn/e;->b(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$5;->a:Lchat/ola/vn/activity/OlaAppSettingActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->a(Lchat/ola/vn/activity/OlaAppSettingActivity;)Lchat/ola/vn/b/b;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/b;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
