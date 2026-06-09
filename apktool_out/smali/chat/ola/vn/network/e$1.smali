.class Lchat/ola/vn/network/e$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(ISLjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:S

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:[B

.field final synthetic e:S

.field final synthetic f:[Lchat/ola/vn/entity/d;

.field final synthetic g:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;ISLjava/lang/String;[BS[Lchat/ola/vn/entity/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iput p2, p0, Lchat/ola/vn/network/e$1;->a:I

    iput-short p3, p0, Lchat/ola/vn/network/e$1;->b:S

    iput-object p4, p0, Lchat/ola/vn/network/e$1;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/network/e$1;->d:[B

    iput-short p6, p0, Lchat/ola/vn/network/e$1;->e:S

    iput-object p7, p0, Lchat/ola/vn/network/e$1;->f:[Lchat/ola/vn/entity/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    if-eqz v0, :cond_14

    iget v0, p0, Lchat/ola/vn/network/e$1;->a:I

    const/4 v1, 0x7

    const/16 v2, 0x3a

    const/4 v3, 0x3

    const/16 v4, 0x3b

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x5

    const/4 v8, 0x1

    if-eq v0, v1, :cond_c

    const/16 v1, 0xa

    if-eq v0, v1, :cond_c

    const/16 v1, 0x18

    if-eq v0, v1, :cond_12

    const/16 v1, 0x29

    if-eq v0, v1, :cond_9

    packed-switch v0, :pswitch_data_0

    packed-switch v0, :pswitch_data_1

    goto/16 :goto_b

    :pswitch_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    if-eqz v0, :cond_12

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    const-string v1, "FAIL_NOT_ENOUGH_MONEY"

    invoke-static {v0, v1}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;)Landroid/app/Dialog;

    goto/16 :goto_b

    :pswitch_1
    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v0

    if-nez v0, :cond_12

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    if-eqz v0, :cond_12

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;)Landroid/app/Dialog;

    goto/16 :goto_b

    :pswitch_2
    iget-short v0, p0, Lchat/ola/vn/network/e$1;->b:S

    if-ne v0, v4, :cond_1

    sput v5, Lchat/ola/vn/network/e;->b:I

    invoke-static {v6}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->j()I

    move-result v0

    if-le v0, v7, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v8}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_12

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget v2, p0, Lchat/ola/vn/network/e$1;->a:I

    iget-object v3, p0, Lchat/ola/vn/network/e$1;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/network/e$1;->d:[B

    invoke-interface {v1, v2, v3, v4}, Lchat/ola/vn/network/f;->a(ILjava/lang/String;[B)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_12

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget-object v2, p0, Lchat/ola/vn/network/e$1;->c:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/network/e$1;->d:[B

    invoke-interface {v1, v2, v3}, Lchat/ola/vn/network/f;->a(Ljava/lang/String;[B)V

    goto :goto_1

    :pswitch_3
    iget-short v0, p0, Lchat/ola/vn/network/e$1;->b:S

    if-ne v0, v4, :cond_12

    sget v0, Lchat/ola/vn/network/e;->b:I

    add-int/2addr v0, v8

    sput v0, Lchat/ola/vn/network/e;->b:I

    sget v0, Lchat/ola/vn/network/e;->b:I

    if-lt v0, v3, :cond_2

    sput v5, Lchat/ola/vn/network/e;->b:I

    invoke-static {v6}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->j()I

    move-result v0

    if-le v0, v7, :cond_12

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v8}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    goto/16 :goto_b

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->j()I

    move-result v0

    if-le v0, v7, :cond_3

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v8}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->m()V

    return-void

    :pswitch_4
    iget-short v0, p0, Lchat/ola/vn/network/e$1;->b:S

    if-ne v0, v2, :cond_7

    invoke-static {}, Lchat/ola/vn/h;->h()Z

    move-result v0

    const/4 v1, 0x6

    if-eqz v0, :cond_5

    sget v0, Lchat/ola/vn/network/e;->b:I

    if-ge v0, v3, :cond_5

    sget v0, Lchat/ola/vn/network/e;->b:I

    add-int/2addr v0, v8

    sput v0, Lchat/ola/vn/network/e;->b:I

    invoke-static {v6}, Lchat/ola/vn/h;->c(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->j()I

    move-result v0

    if-ne v0, v1, :cond_4

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v7}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    goto :goto_2

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v8}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    :goto_3
    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->m()V

    goto/16 :goto_b

    :cond_5
    sput v5, Lchat/ola/vn/network/e;->b:I

    invoke-static {v6}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/c/b;->e(Landroid/content/Context;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->j()I

    move-result v0

    if-le v0, v1, :cond_6

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v8}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_4
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_12

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget v2, p0, Lchat/ola/vn/network/e$1;->a:I

    iget-object v3, p0, Lchat/ola/vn/network/e$1;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/network/e$1;->d:[B

    invoke-interface {v1, v2, v3, v4}, Lchat/ola/vn/network/f;->a(ILjava/lang/String;[B)V

    goto :goto_4

    :cond_7
    iget-short v0, p0, Lchat/ola/vn/network/e$1;->b:S

    if-ne v0, v4, :cond_12

    invoke-static {v6}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->j()I

    move-result v0

    if-le v0, v7, :cond_8

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v8}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    :cond_8
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_5
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_12

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget v2, p0, Lchat/ola/vn/network/e$1;->a:I

    iget-object v3, p0, Lchat/ola/vn/network/e$1;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/network/e$1;->d:[B

    invoke-interface {v1, v2, v3, v4}, Lchat/ola/vn/network/f;->a(ILjava/lang/String;[B)V

    goto :goto_5

    :cond_9
    iget-short v0, p0, Lchat/ola/vn/network/e$1;->b:S

    if-ne v0, v4, :cond_b

    sput v5, Lchat/ola/vn/network/e;->b:I

    invoke-static {v6}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->j()I

    move-result v0

    if-le v0, v7, :cond_a

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v8}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    :cond_a
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_6
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_12

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget-object v2, p0, Lchat/ola/vn/network/e$1;->c:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/network/e$1;->d:[B

    invoke-interface {v1, v2, v3}, Lchat/ola/vn/network/f;->b(Ljava/lang/String;[B)V

    goto :goto_6

    :cond_b
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_7
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_12

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget-object v2, p0, Lchat/ola/vn/network/e$1;->c:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/network/e$1;->d:[B

    invoke-interface {v1, v2, v3}, Lchat/ola/vn/network/f;->a(Ljava/lang/String;[B)V

    goto :goto_7

    :cond_c
    iget-short v0, p0, Lchat/ola/vn/network/e$1;->b:S

    if-ne v0, v2, :cond_10

    invoke-static {}, Lchat/ola/vn/h;->h()Z

    move-result v0

    if-eqz v0, :cond_e

    sget v0, Lchat/ola/vn/network/e;->b:I

    if-ge v0, v3, :cond_e

    sget v0, Lchat/ola/vn/network/e;->b:I

    add-int/2addr v0, v8

    sput v0, Lchat/ola/vn/network/e;->b:I

    invoke-static {v6}, Lchat/ola/vn/h;->c(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->j()I

    move-result v0

    if-le v0, v7, :cond_d

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v7}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    goto :goto_8

    :cond_d
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v8}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    :goto_8
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    goto/16 :goto_3

    :cond_e
    sput v5, Lchat/ola/vn/network/e;->b:I

    invoke-static {v6}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/c/b;->e(Landroid/content/Context;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->j()I

    move-result v0

    if-le v0, v7, :cond_f

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v8}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    :cond_f
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_9
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_12

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget v2, p0, Lchat/ola/vn/network/e$1;->a:I

    iget-object v3, p0, Lchat/ola/vn/network/e$1;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/network/e$1;->d:[B

    invoke-interface {v1, v2, v3, v4}, Lchat/ola/vn/network/f;->a(ILjava/lang/String;[B)V

    goto :goto_9

    :cond_10
    iget-short v0, p0, Lchat/ola/vn/network/e$1;->b:S

    if-ne v0, v4, :cond_12

    sput v5, Lchat/ola/vn/network/e;->b:I

    invoke-static {v6}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/network/e$1;->c:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->j()I

    move-result v0

    if-le v0, v7, :cond_11

    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v8}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    :cond_11
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_a
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_12

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget v2, p0, Lchat/ola/vn/network/e$1;->a:I

    iget-object v3, p0, Lchat/ola/vn/network/e$1;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/network/e$1;->d:[B

    invoke-interface {v1, v2, v3, v4}, Lchat/ola/vn/network/f;->a(ILjava/lang/String;[B)V

    goto :goto_a

    :cond_12
    :goto_b
    iget-short v0, p0, Lchat/ola/vn/network/e$1;->b:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_13

    iget v1, p0, Lchat/ola/vn/network/e$1;->a:I

    iget-short v2, p0, Lchat/ola/vn/network/e$1;->e:S

    iget-object v3, p0, Lchat/ola/vn/network/e$1;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/network/e$1;->f:[Lchat/ola/vn/entity/d;

    invoke-virtual {v0, v1, v2, v3, v4}, Lchat/ola/vn/entry/c/e;->a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V

    :cond_13
    iget-object v0, p0, Lchat/ola/vn/network/e$1;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_c
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_14

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    move-object v2, v1

    check-cast v2, Lchat/ola/vn/network/f;

    iget v3, p0, Lchat/ola/vn/network/e$1;->a:I

    iget-object v4, p0, Lchat/ola/vn/network/e$1;->c:Ljava/lang/String;

    iget-object v5, p0, Lchat/ola/vn/network/e$1;->d:[B

    iget-object v6, p0, Lchat/ola/vn/network/e$1;->f:[Lchat/ola/vn/entity/d;

    iget-short v7, p0, Lchat/ola/vn/network/e$1;->b:S

    invoke-interface/range {v2 .. v7}, Lchat/ola/vn/network/f;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_c

    :catch_0
    :cond_14
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x26
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
