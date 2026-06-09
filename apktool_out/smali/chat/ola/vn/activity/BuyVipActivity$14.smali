.class Lchat/ola/vn/activity/BuyVipActivity$14;
.super Lchat/ola/vn/b/aa;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/BuyVipActivity;->F()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/aa<",
        "Lchat/ola/vn/entity/ac;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/BuyVipActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/BuyVipActivity;Landroid/content/Context;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$14;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/b/aa;-><init>(Landroid/content/Context;Ljava/util/List;)V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/ac;)Ljava/lang/CharSequence;
    .locals 7

    iget-object v0, p1, Lchat/ola/vn/entity/ac;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    const/4 v3, 0x2

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/activity/BuyVipActivity$14;->b()Landroid/content/Context;

    move-result-object v0

    const v4, 0x7f0f06f7

    new-array v3, v3, [Ljava/lang/Object;

    iget-wide v5, p1, Lchat/ola/vn/entity/ac;->c:J

    invoke-static {v5, v6}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v2

    iget p1, p1, Lchat/ola/vn/entity/ac;->d:I

    int-to-long v5, p1

    invoke-static {v5, v6}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    aput-object p1, v3, v1

    :goto_0
    invoke-virtual {v0, v4, v3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/BuyVipActivity$14;->b()Landroid/content/Context;

    move-result-object v0

    const v4, 0x7f0f06f8

    new-array v3, v3, [Ljava/lang/Object;

    iget-object v5, p1, Lchat/ola/vn/entity/ac;->a:Ljava/lang/String;

    aput-object v5, v3, v2

    iget p1, p1, Lchat/ola/vn/entity/ac;->d:I

    int-to-long v5, p1

    invoke-static {v5, v6}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    aput-object p1, v3, v1

    goto :goto_0
.end method

.method public bridge synthetic a(Ljava/lang/Object;)Ljava/lang/CharSequence;
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/ac;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/BuyVipActivity$14;->a(Lchat/ola/vn/entity/ac;)Ljava/lang/CharSequence;

    move-result-object p1

    return-object p1
.end method
