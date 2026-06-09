.class Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2$1;->a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2$1;->a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;->a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->a(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;)V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
