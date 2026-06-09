.class Lchat/ola/vn/activity/ClanManagementActivity$7;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/ClanManagementActivity;->N()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/activity/ClanManagementActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/ClanManagementActivity;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/ClanManagementActivity$7;->b:Lchat/ola/vn/activity/ClanManagementActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/ClanManagementActivity$7;->a:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/ClanManagementActivity$7;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/activity/ClanManagementActivity$7;->b:Lchat/ola/vn/activity/ClanManagementActivity;

    const p3, 0x7f0f01e2

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object p1

    const/4 p2, 0x0

    iput-short p2, p1, Lchat/ola/vn/entity/b;->j:S

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/ClanManagementActivity$7;->b:Lchat/ola/vn/activity/ClanManagementActivity;

    const p3, 0x7f0f01e1

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object p1

    const/4 p2, 0x1

    iput-short p2, p1, Lchat/ola/vn/entity/b;->j:S

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/activity/ClanManagementActivity$7;->b:Lchat/ola/vn/activity/ClanManagementActivity;

    const p3, 0x7f0f01e3

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object p1

    const/4 p2, 0x2

    iput-short p2, p1, Lchat/ola/vn/entity/b;->j:S

    goto :goto_0

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/activity/ClanManagementActivity$7;->b:Lchat/ola/vn/activity/ClanManagementActivity;

    const p3, 0x7f0f01e4

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object p1

    const/4 p2, 0x4

    iput-short p2, p1, Lchat/ola/vn/entity/b;->j:S

    goto :goto_0

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/activity/ClanManagementActivity$7;->b:Lchat/ola/vn/activity/ClanManagementActivity;

    const p3, 0x7f0f01e0

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object p1

    const/4 p2, 0x3

    iput-short p2, p1, Lchat/ola/vn/entity/b;->j:S

    :cond_4
    :goto_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object p2

    iget-object p2, p2, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/activity/ClanManagementActivity;->I()Lchat/ola/vn/entity/b;

    move-result-object p3

    iget-short p3, p3, Lchat/ola/vn/entity/b;->j:S

    invoke-virtual {p1, p2, p3}, Lchat/ola/vn/network/OlaNetworkService;->m(Ljava/lang/String;S)V

    iget-object p1, p0, Lchat/ola/vn/activity/ClanManagementActivity$7;->b:Lchat/ola/vn/activity/ClanManagementActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/ClanManagementActivity;->b(Lchat/ola/vn/activity/ClanManagementActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
