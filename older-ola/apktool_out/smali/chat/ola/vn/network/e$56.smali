.class Lchat/ola/vn/network/e$56;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->c(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$56;->b:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 11

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/af;

    invoke-virtual {v3}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v4

    const-string v5, "#daptrung"

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    invoke-virtual {v3}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    const-string v4, "lk"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v0, 0x1

    const/4 v3, 0x0

    goto :goto_1

    :cond_2
    const/4 v0, 0x1

    :goto_0
    const/4 v3, 0x1

    :goto_1
    const/4 v4, 0x0

    if-eqz v0, :cond_3

    new-instance v0, Lchat/ola/vn/entity/af;

    const v5, 0x7f0f06cd

    invoke-static {v5}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v5

    const-string v6, "#daptrung"

    invoke-direct {v0, v5, v6}, Lchat/ola/vn/entity/af;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    :cond_3
    move-object v0, v4

    :goto_2
    if-eqz v3, :cond_4

    new-instance v4, Lchat/ola/vn/entity/af;

    const v3, 0x7f0f06cf

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    const-string v5, "lk"

    invoke-direct {v4, v3, v5}, Lchat/ola/vn/entity/af;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    :cond_4
    new-instance v3, Lchat/ola/vn/entity/af;

    const-string v5, "#Android"

    const-string v6, "#apk"

    invoke-direct {v3, v5, v6}, Lchat/ola/vn/entity/af;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v5, Lchat/ola/vn/entity/af;

    const-string v6, "#Ola"

    const-string v7, "#Ola"

    invoke-direct {v5, v6, v7}, Lchat/ola/vn/entity/af;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v6, Lchat/ola/vn/entity/af;

    const v7, 0x7f0f06ce

    invoke-static {v7}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v7

    const-string v8, "#hai"

    invoke-direct {v6, v7, v8}, Lchat/ola/vn/entity/af;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v7, Lchat/ola/vn/entity/af;

    const v8, 0x7f0f06cc

    invoke-static {v8}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v8

    const-string v9, "my diary"

    invoke-direct {v7, v8, v9}, Lchat/ola/vn/entity/af;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v8, Lchat/ola/vn/entity/af;

    const v9, 0x7f0f06ca

    invoke-static {v9}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v9

    const-string v10, "mariage diary"

    invoke-direct {v8, v9, v10}, Lchat/ola/vn/entity/af;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v9, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    if-eqz v9, :cond_7

    iget-object v9, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    invoke-interface {v9, v1, v7}, Ljava/util/List;->add(ILjava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    invoke-interface {v1, v2, v8}, Ljava/util/List;->add(ILjava/lang/Object;)V

    if-eqz v4, :cond_5

    iget-object v1, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_5
    if-eqz v0, :cond_6

    iget-object v1, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    invoke-static {v0}, Lchat/ola/vn/h/b;->d(Ljava/util/List;)V

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    iget-object v1, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/a/e;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$56;->b:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_7

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget-object v2, p0, Lchat/ola/vn/network/e$56;->a:Ljava/util/List;

    invoke-interface {v1, v2}, Lchat/ola/vn/network/f;->b(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    :catch_0
    :cond_7
    return-void
.end method
