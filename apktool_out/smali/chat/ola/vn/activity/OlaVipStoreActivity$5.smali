.class Lchat/ola/vn/activity/OlaVipStoreActivity$5;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaVipStoreActivity;->f(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/activity/OlaVipStoreActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaVipStoreActivity;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$5;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$5;->a:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x16

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 3

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$5;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const/4 p4, 0x0

    invoke-static {p2, p4}, Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Lchat/ola/vn/activity/OlaVipStoreActivity;Z)V

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$5;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const p3, 0x7f0f0250

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object p3

    :cond_0
    const/16 p2, 0x26

    const v0, 0x7f0f00a2

    if-eq p1, p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$5;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$5;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    invoke-virtual {p2, v0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    :goto_0
    invoke-static {p1, p2, p3}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$5;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$5;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    invoke-virtual {p2, v0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$5;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const v0, 0x7f0f0254

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$5;->a:Ljava/lang/String;

    aput-object v2, v1, p4

    invoke-virtual {p3, v0, v1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 9

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$5;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Lchat/ola/vn/activity/OlaVipStoreActivity;Z)V

    aget-object v0, p1, v1

    move-object v2, v0

    check-cast v2, Ljava/lang/String;

    const/4 v0, 0x1

    aget-object v0, p1, v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v3

    const/4 v0, 0x2

    aget-object v0, p1, v0

    check-cast v0, Ljava/lang/Short;

    invoke-virtual {v0}, Ljava/lang/Short;->shortValue()S

    move-result v4

    const/4 v0, 0x3

    aget-object v0, p1, v0

    move-object v5, v0

    check-cast v5, Ljava/lang/String;

    const/4 v0, 0x4

    aget-object v0, p1, v0

    check-cast v0, Ljava/lang/Long;

    const/4 v1, 0x5

    aget-object p1, p1, v1

    move-object v8, p1

    check-cast v8, Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$5;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    invoke-virtual/range {v1 .. v8}, Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Ljava/lang/String;ISLjava/lang/String;JLjava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
