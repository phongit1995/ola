.class public abstract Lcom/mg/ola/common/widget/image/viewer/d;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/common/widget/image/viewer/d$b;,
        Lcom/mg/ola/common/widget/image/viewer/d$a;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Landroid/content/Context;)Lcom/mg/ola/common/widget/image/viewer/d;
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x9

    if-ge v0, v1, :cond_0

    new-instance v0, Lcom/mg/ola/common/widget/image/viewer/d$b;

    invoke-direct {v0, p0}, Lcom/mg/ola/common/widget/image/viewer/d$b;-><init>(Landroid/content/Context;)V

    return-object v0

    :cond_0
    new-instance v0, Lcom/mg/ola/common/widget/image/viewer/d$a;

    invoke-direct {v0, p0}, Lcom/mg/ola/common/widget/image/viewer/d$a;-><init>(Landroid/content/Context;)V

    return-object v0
.end method


# virtual methods
.method public abstract a(IIIIIIIIII)V
.end method

.method public abstract a(Z)V
.end method

.method public abstract a()Z
.end method

.method public abstract b()I
.end method

.method public abstract c()I
.end method
