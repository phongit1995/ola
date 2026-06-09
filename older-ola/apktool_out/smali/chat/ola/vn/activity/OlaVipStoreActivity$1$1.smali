.class Lchat/ola/vn/activity/OlaVipStoreActivity$1$1;
.super Lchat/ola/vn/entry/c/a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaVipStoreActivity$1;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaVipStoreActivity$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaVipStoreActivity$1;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$1$1;->a:Lchat/ola/vn/activity/OlaVipStoreActivity$1;

    invoke-direct {p0, p2}, Lchat/ola/vn/entry/c/a;-><init>(S)V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x1b

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$1$1;->a:Lchat/ola/vn/activity/OlaVipStoreActivity$1;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaVipStoreActivity$1;->a:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, ""

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const v1, 0x7f0f01c6

    invoke-static {p1, v1, v0}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;I[Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$1$1;->a:Lchat/ola/vn/activity/OlaVipStoreActivity$1;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaVipStoreActivity$1;->a:Lchat/ola/vn/activity/OlaVipStoreActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->B()V

    return-void
.end method
