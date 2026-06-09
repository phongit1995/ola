.class Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->c_()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$1;->a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    :try_start_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$1;->a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->finish()V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$1;->a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->a(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
