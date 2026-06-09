.class Lcom/mg/ola/common/widget/b$b;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/b;


# direct methods
.method private constructor <init>(Lcom/mg/ola/common/widget/b;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/b$b;->a:Lcom/mg/ola/common/widget/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mg/ola/common/widget/b;Lcom/mg/ola/common/widget/b$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/b$b;-><init>(Lcom/mg/ola/common/widget/b;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/b$b;->a:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b;->e()V

    return-void
.end method
