.class Lchat/ola/vn/activity/ClanManagementActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/ClanManagementActivity;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/ClanManagementActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/ClanManagementActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/ClanManagementActivity$2;->a:Lchat/ola/vn/activity/ClanManagementActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 7

    if-eqz p2, :cond_0

    goto/16 :goto_0

    :cond_0
    :try_start_0
    move-object p2, p1

    check-cast p2, Lchat/ola/vn/i/p;

    invoke-virtual {p2}, Lchat/ola/vn/i/p;->a()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object v0

    invoke-static {p2}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, v0, Lchat/ola/vn/entity/b;->d:Ljava/lang/String;

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object v0

    iget-object v0, v0, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object v1

    iget-object v1, v1, Lchat/ola/vn/entity/b;->d:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->f(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/activity/ClanManagementActivity$2;->a:Lchat/ola/vn/activity/ClanManagementActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/ClanManagementActivity;->a(Lchat/ola/vn/activity/ClanManagementActivity;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity$2;->a:Lchat/ola/vn/activity/ClanManagementActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/ClanManagementActivity$2;->a:Lchat/ola/vn/activity/ClanManagementActivity;

    const v1, 0x7f0f009b

    invoke-virtual {p2, v1}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p2, p0, Lchat/ola/vn/activity/ClanManagementActivity$2;->a:Lchat/ola/vn/activity/ClanManagementActivity;

    const v2, 0x7f0f0232

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "@"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object v6

    iget-object v6, v6, Lchat/ola/vn/entity/b;->d:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-virtual {p2, v2, v3}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object p2, p0, Lchat/ola/vn/activity/ClanManagementActivity$2;->a:Lchat/ola/vn/activity/ClanManagementActivity;

    const v3, 0x7f0f06c2

    invoke-virtual {p2, v3}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p2, p0, Lchat/ola/vn/activity/ClanManagementActivity$2;->a:Lchat/ola/vn/activity/ClanManagementActivity;

    const v4, 0x7f0f0577

    invoke-virtual {p2, v4}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/activity/ClanManagementActivity$2$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/ClanManagementActivity$2$1;-><init>(Lchat/ola/vn/activity/ClanManagementActivity$2;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    :try_start_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method
