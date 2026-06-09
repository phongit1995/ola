.class Lchat/ola/vn/activity/ClanManagementActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/ClanManagementActivity;->B()V
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

    iput-object p1, p0, Lchat/ola/vn/activity/ClanManagementActivity$3;->a:Lchat/ola/vn/activity/ClanManagementActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 6

    if-nez p2, :cond_0

    move-object p2, p1

    check-cast p2, Lchat/ola/vn/i/p;

    invoke-virtual {p2}, Lchat/ola/vn/i/p;->a()Ljava/lang/String;

    move-result-object p2

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object v1

    iget-object v1, v1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-virtual {v0, p2, v1}, Lchat/ola/vn/network/OlaNetworkService;->i(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity$3;->a:Lchat/ola/vn/activity/ClanManagementActivity;

    const v1, 0x7f0f01e7

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\'@"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "\""

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    aput-object p2, v2, v3

    const/4 p2, 0x1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\"#"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object v4

    iget-object v4, v4, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "\""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, p2

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;I[Ljava/lang/Object;)V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
