.class Lchat/ola/vn/activity/BuyVipActivity$18;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/view/OlaSuggestEditText$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/BuyVipActivity;->F()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/BuyVipActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/BuyVipActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$18;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;)Ljava/lang/String;
    .locals 7

    check-cast p1, Lchat/ola/vn/entity/ac;

    iget-object v0, p1, Lchat/ola/vn/entity/ac;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    const/4 v3, 0x2

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity$18;->a:Lchat/ola/vn/activity/BuyVipActivity;

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
    invoke-virtual {v0, v4, v3}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity$18;->a:Lchat/ola/vn/activity/BuyVipActivity;

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
