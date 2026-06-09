.class Lcom/mg/ola/common/widget/a$a;
.super Landroid/database/DataSetObserver;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/a;

.field private b:Landroid/os/Parcelable;


# direct methods
.method constructor <init>(Lcom/mg/ola/common/widget/a;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    invoke-direct {p0}, Landroid/database/DataSetObserver;-><init>()V

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/mg/ola/common/widget/a$a;->b:Landroid/os/Parcelable;

    return-void
.end method


# virtual methods
.method public onChanged()V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/mg/ola/common/widget/a;->v:Z

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    iget-object v1, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    iget v1, v1, Lcom/mg/ola/common/widget/a;->A:I

    iput v1, v0, Lcom/mg/ola/common/widget/a;->B:I

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    iget-object v1, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v1

    invoke-interface {v1}, Landroid/widget/Adapter;->getCount()I

    move-result v1

    iput v1, v0, Lcom/mg/ola/common/widget/a;->A:I

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v0

    invoke-interface {v0}, Landroid/widget/Adapter;->hasStableIds()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->b:Landroid/os/Parcelable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    iget v0, v0, Lcom/mg/ola/common/widget/a;->B:I

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    iget v0, v0, Lcom/mg/ola/common/widget/a;->A:I

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    iget-object v1, p0, Lcom/mg/ola/common/widget/a$a;->b:Landroid/os/Parcelable;

    invoke-static {v0, v1}, Lcom/mg/ola/common/widget/a;->a(Lcom/mg/ola/common/widget/a;Landroid/os/Parcelable;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/common/widget/a$a;->b:Landroid/os/Parcelable;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/a;->h()V

    :goto_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/a;->c()V

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/a;->requestLayout()V

    return-void
.end method

.method public onInvalidated()V
    .locals 5

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/mg/ola/common/widget/a;->v:Z

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v0

    invoke-interface {v0}, Landroid/widget/Adapter;->hasStableIds()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    invoke-static {v0}, Lcom/mg/ola/common/widget/a;->a(Lcom/mg/ola/common/widget/a;)Landroid/os/Parcelable;

    move-result-object v0

    iput-object v0, p0, Lcom/mg/ola/common/widget/a$a;->b:Landroid/os/Parcelable;

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    iget-object v1, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    iget v1, v1, Lcom/mg/ola/common/widget/a;->A:I

    iput v1, v0, Lcom/mg/ola/common/widget/a;->B:I

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    const/4 v1, 0x0

    iput v1, v0, Lcom/mg/ola/common/widget/a;->A:I

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    const/4 v2, -0x1

    iput v2, v0, Lcom/mg/ola/common/widget/a;->y:I

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    const-wide/high16 v3, -0x8000000000000000L

    iput-wide v3, v0, Lcom/mg/ola/common/widget/a;->z:J

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    iput v2, v0, Lcom/mg/ola/common/widget/a;->w:I

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    iput-wide v3, v0, Lcom/mg/ola/common/widget/a;->x:J

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    iput-boolean v1, v0, Lcom/mg/ola/common/widget/a;->p:Z

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/a;->c()V

    iget-object v0, p0, Lcom/mg/ola/common/widget/a$a;->a:Lcom/mg/ola/common/widget/a;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/a;->requestLayout()V

    return-void
.end method
