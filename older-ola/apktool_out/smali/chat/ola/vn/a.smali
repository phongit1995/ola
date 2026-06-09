.class public Lchat/ola/vn/a;
.super Ljava/lang/Object;


# static fields
.field private static a:Lchat/ola/vn/a;


# instance fields
.field private b:Lcom/mg/ola/common/b/d;

.field private c:Lcom/mg/ola/common/b/d;

.field private d:Lcom/mg/ola/common/b/b;

.field private e:Lcom/mg/ola/common/b/d;

.field private f:Lcom/mg/ola/common/b/d;


# direct methods
.method private constructor <init>()V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0025

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/a;->c:Lcom/mg/ola/common/b/d;

    new-instance v1, Lcom/mg/ola/common/b/b;

    const v2, 0x7f0f03fd

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/b;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/a;->d:Lcom/mg/ola/common/b/b;

    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f03fa

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/a;->b:Lcom/mg/ola/common/b/d;

    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f03fb

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/a;->f:Lcom/mg/ola/common/b/d;

    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f03fc

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/a;->e:Lcom/mg/ola/common/b/d;

    return-void
.end method

.method public static a()Lchat/ola/vn/a;
    .locals 1

    sget-object v0, Lchat/ola/vn/a;->a:Lchat/ola/vn/a;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/a;

    invoke-direct {v0}, Lchat/ola/vn/a;-><init>()V

    sput-object v0, Lchat/ola/vn/a;->a:Lchat/ola/vn/a;

    :cond_0
    sget-object v0, Lchat/ola/vn/a;->a:Lchat/ola/vn/a;

    return-object v0
.end method


# virtual methods
.method public a(I)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/a;->d:Lcom/mg/ola/common/b/b;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/b;->b(Ljava/lang/Integer;)V

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/a;->f:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V

    return-void
.end method
