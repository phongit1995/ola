.class Lchat/ola/vn/activity/ClanManagementActivity$2$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/ClanManagementActivity$2;->onClick(Landroid/content/DialogInterface;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/ClanManagementActivity$2;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/ClanManagementActivity$2;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/ClanManagementActivity$2$1;->a:Lchat/ola/vn/activity/ClanManagementActivity$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object p2

    const/4 v0, 0x0

    iput-object v0, p2, Lchat/ola/vn/entity/b;->d:Ljava/lang/String;

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object v0

    iget-object v0, v0, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object v1

    iget-object v1, v1, Lchat/ola/vn/entity/b;->d:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->f(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/activity/ClanManagementActivity$2$1;->a:Lchat/ola/vn/activity/ClanManagementActivity$2;

    iget-object p2, p2, Lchat/ola/vn/activity/ClanManagementActivity$2;->a:Lchat/ola/vn/activity/ClanManagementActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/ClanManagementActivity;->a(Lchat/ola/vn/activity/ClanManagementActivity;)V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
