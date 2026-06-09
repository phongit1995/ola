.class Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private c:Landroid/view/LayoutInflater;


# direct methods
.method public constructor <init>(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;->a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

    invoke-direct {p0, p2}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;->c:Landroid/view/LayoutInflater;

    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 4

    if-nez p2, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;->c:Landroid/view/LayoutInflater;

    const v1, 0x7f0b00cc

    const/4 v2, 0x0

    invoke-virtual {v0, v1, p3, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance p2, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;->a:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

    const/4 v1, 0x0

    invoke-direct {p2, v0, v1}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;-><init>(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$1;)V

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->a(Landroid/view/View;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    goto :goto_1

    :catch_1
    move-exception p1

    move-object p3, p2

    goto :goto_1

    :cond_0
    :try_start_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    move-object v3, p3

    move-object p3, p2

    move-object p2, v3

    :goto_0
    :try_start_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-virtual {p2, p1}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;->a(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    return-object p3

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-object p3
.end method

.method public a(I)Ljava/lang/String;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;->b:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;->b:Ljava/util/List;

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;->b:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;->a(I)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method
