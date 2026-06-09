.class Lcom/mg/ola/a/a/b/c$c;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/a/a/b/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "c"
.end annotation


# instance fields
.field public a:Lcom/mg/ola/a/a/b/c$e;

.field public b:I


# direct methods
.method public constructor <init>(Lcom/mg/ola/a/a/b/c$e;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/mg/ola/a/a/b/c$c;->a:Lcom/mg/ola/a/a/b/c$e;

    iput p2, p0, Lcom/mg/ola/a/a/b/c$c;->b:I

    return-void
.end method
