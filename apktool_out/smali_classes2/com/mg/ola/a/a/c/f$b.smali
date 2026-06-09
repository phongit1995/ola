.class Lcom/mg/ola/a/a/c/f$b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/a/a/c/f;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "b"
.end annotation


# instance fields
.field a:I

.field b:F

.field c:F


# direct methods
.method constructor <init>(IFF)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/mg/ola/a/a/c/f$b;->a:I

    iput p2, p0, Lcom/mg/ola/a/a/c/f$b;->b:F

    iput p3, p0, Lcom/mg/ola/a/a/c/f$b;->c:F

    return-void
.end method
