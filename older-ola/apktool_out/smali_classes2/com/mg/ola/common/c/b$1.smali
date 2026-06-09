.class Lcom/mg/ola/common/c/b$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/animation/Interpolator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mg/ola/common/c/b;-><init>(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/c/b;


# direct methods
.method constructor <init>(Lcom/mg/ola/common/c/b;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/c/b$1;->a:Lcom/mg/ola/common/c/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getInterpolation(F)F
    .locals 1

    const v0, 0x3fc66666    # 1.55f

    mul-float p1, p1, v0

    const v0, 0x3f8ccccd    # 1.1f

    sub-float/2addr p1, v0

    mul-float p1, p1, p1

    const v0, 0x3f99999a    # 1.2f

    sub-float/2addr v0, p1

    return v0
.end method
