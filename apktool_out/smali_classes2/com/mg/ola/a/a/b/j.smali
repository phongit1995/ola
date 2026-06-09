.class public final Lcom/mg/ola/a/a/b/j;
.super Lcom/mg/ola/a/a/b/n;


# static fields
.field private static final h:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/mg/ola/a/a/a/c;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private i:Ljava/lang/Object;

.field private j:Ljava/lang/String;

.field private k:Lcom/mg/ola/a/a/a/c;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "alpha"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->a:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "pivotX"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->b:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "pivotY"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->c:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "translationX"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->d:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "translationY"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->e:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "rotation"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->f:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "rotationX"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->g:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "rotationY"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->h:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "scaleX"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->i:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "scaleY"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->j:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "scrollX"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->k:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "scrollY"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->l:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "x"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->m:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    const-string v1, "y"

    sget-object v2, Lcom/mg/ola/a/a/b/k;->n:Lcom/mg/ola/a/a/a/c;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/n;-><init>()V

    return-void
.end method

.method private constructor <init>(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/n;-><init>()V

    iput-object p1, p0, Lcom/mg/ola/a/a/b/j;->i:Ljava/lang/Object;

    invoke-virtual {p0, p2}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/String;)V

    return-void
.end method

.method public static varargs a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;
    .locals 1

    new-instance v0, Lcom/mg/ola/a/a/b/j;

    invoke-direct {v0, p0, p1}, Lcom/mg/ola/a/a/b/j;-><init>(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Lcom/mg/ola/a/a/b/j;->a([F)V

    return-object v0
.end method


# virtual methods
.method public synthetic a(J)Lcom/mg/ola/a/a/b/a;
    .locals 0

    invoke-virtual {p0, p1, p2}, Lcom/mg/ola/a/a/b/j;->b(J)Lcom/mg/ola/a/a/b/j;

    move-result-object p1

    return-object p1
.end method

.method public a()V
    .locals 0

    invoke-super {p0}, Lcom/mg/ola/a/a/b/n;->a()V

    return-void
.end method

.method a(F)V
    .locals 3

    invoke-super {p0, p1}, Lcom/mg/ola/a/a/b/n;->a(F)V

    iget-object p1, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    array-length p1, p1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, p1, :cond_0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    aget-object v1, v1, v0

    iget-object v2, p0, Lcom/mg/ola/a/a/b/j;->i:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Lcom/mg/ola/a/a/b/l;->b(Ljava/lang/Object;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public a(Lcom/mg/ola/a/a/a/c;)V
    .locals 4

    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    aget-object v0, v0, v1

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/l;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1}, Lcom/mg/ola/a/a/b/l;->a(Lcom/mg/ola/a/a/a/c;)V

    iget-object v3, p0, Lcom/mg/ola/a/a/b/j;->g:Ljava/util/HashMap;

    invoke-virtual {v3, v2}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v2, p0, Lcom/mg/ola/a/a/b/j;->g:Ljava/util/HashMap;

    iget-object v3, p0, Lcom/mg/ola/a/a/b/j;->j:Ljava/lang/String;

    invoke-virtual {v2, v3, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->k:Lcom/mg/ola/a/a/a/c;

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lcom/mg/ola/a/a/a/c;->a()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mg/ola/a/a/b/j;->j:Ljava/lang/String;

    :cond_1
    iput-object p1, p0, Lcom/mg/ola/a/a/b/j;->k:Lcom/mg/ola/a/a/a/c;

    iput-boolean v1, p0, Lcom/mg/ola/a/a/b/j;->e:Z

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 4

    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    aget-object v0, v0, v1

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/l;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1}, Lcom/mg/ola/a/a/b/l;->a(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/mg/ola/a/a/b/j;->g:Ljava/util/HashMap;

    invoke-virtual {v3, v2}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v2, p0, Lcom/mg/ola/a/a/b/j;->g:Ljava/util/HashMap;

    invoke-virtual {v2, p1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    iput-object p1, p0, Lcom/mg/ola/a/a/b/j;->j:Ljava/lang/String;

    iput-boolean v1, p0, Lcom/mg/ola/a/a/b/j;->e:Z

    return-void
.end method

.method public varargs a([F)V
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    array-length v0, v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-super {p0, p1}, Lcom/mg/ola/a/a/b/n;->a([F)V

    return-void

    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->k:Lcom/mg/ola/a/a/a/c;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_2

    new-array v0, v2, [Lcom/mg/ola/a/a/b/l;

    iget-object v2, p0, Lcom/mg/ola/a/a/b/j;->k:Lcom/mg/ola/a/a/a/c;

    invoke-static {v2, p1}, Lcom/mg/ola/a/a/b/l;->a(Lcom/mg/ola/a/a/a/c;[F)Lcom/mg/ola/a/a/b/l;

    move-result-object p1

    aput-object p1, v0, v1

    :goto_1
    invoke-virtual {p0, v0}, Lcom/mg/ola/a/a/b/j;->a([Lcom/mg/ola/a/a/b/l;)V

    return-void

    :cond_2
    new-array v0, v2, [Lcom/mg/ola/a/a/b/l;

    iget-object v2, p0, Lcom/mg/ola/a/a/b/j;->j:Ljava/lang/String;

    invoke-static {v2, p1}, Lcom/mg/ola/a/a/b/l;->a(Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/l;

    move-result-object p1

    aput-object p1, v0, v1

    goto :goto_1

    return-void
.end method

.method public varargs a([I)V
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    array-length v0, v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-super {p0, p1}, Lcom/mg/ola/a/a/b/n;->a([I)V

    return-void

    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->k:Lcom/mg/ola/a/a/a/c;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_2

    new-array v0, v2, [Lcom/mg/ola/a/a/b/l;

    iget-object v2, p0, Lcom/mg/ola/a/a/b/j;->k:Lcom/mg/ola/a/a/a/c;

    invoke-static {v2, p1}, Lcom/mg/ola/a/a/b/l;->a(Lcom/mg/ola/a/a/a/c;[I)Lcom/mg/ola/a/a/b/l;

    move-result-object p1

    aput-object p1, v0, v1

    :goto_1
    invoke-virtual {p0, v0}, Lcom/mg/ola/a/a/b/j;->a([Lcom/mg/ola/a/a/b/l;)V

    return-void

    :cond_2
    new-array v0, v2, [Lcom/mg/ola/a/a/b/l;

    iget-object v2, p0, Lcom/mg/ola/a/a/b/j;->j:Ljava/lang/String;

    invoke-static {v2, p1}, Lcom/mg/ola/a/a/b/l;->a(Ljava/lang/String;[I)Lcom/mg/ola/a/a/b/l;

    move-result-object p1

    aput-object p1, v0, v1

    goto :goto_1

    return-void
.end method

.method public b(J)Lcom/mg/ola/a/a/b/j;
    .locals 0

    invoke-super {p0, p1, p2}, Lcom/mg/ola/a/a/b/n;->c(J)Lcom/mg/ola/a/a/b/n;

    return-object p0
.end method

.method public synthetic c(J)Lcom/mg/ola/a/a/b/n;
    .locals 0

    invoke-virtual {p0, p1, p2}, Lcom/mg/ola/a/a/b/j;->b(J)Lcom/mg/ola/a/a/b/j;

    move-result-object p1

    return-object p1
.end method

.method public synthetic clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/j;->i()Lcom/mg/ola/a/a/b/j;

    move-result-object v0

    return-object v0
.end method

.method public synthetic g()Lcom/mg/ola/a/a/b/a;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/j;->i()Lcom/mg/ola/a/a/b/j;

    move-result-object v0

    return-object v0
.end method

.method h()V
    .locals 4

    iget-boolean v0, p0, Lcom/mg/ola/a/a/b/j;->e:Z

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->k:Lcom/mg/ola/a/a/a/c;

    if-nez v0, :cond_0

    sget-boolean v0, Lcom/mg/ola/a/a/c/a;->a:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->i:Ljava/lang/Object;

    instance-of v0, v0, Landroid/view/View;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/j;->j:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mg/ola/a/a/b/j;->h:Ljava/util/Map;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/j;->j:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/a/c;

    invoke-virtual {p0, v0}, Lcom/mg/ola/a/a/b/j;->a(Lcom/mg/ola/a/a/a/c;)V

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    array-length v0, v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    iget-object v2, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    aget-object v2, v2, v1

    iget-object v3, p0, Lcom/mg/ola/a/a/b/j;->i:Ljava/lang/Object;

    invoke-virtual {v2, v3}, Lcom/mg/ola/a/a/b/l;->a(Ljava/lang/Object;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    invoke-super {p0}, Lcom/mg/ola/a/a/b/n;->h()V

    :cond_2
    return-void
.end method

.method public i()Lcom/mg/ola/a/a/b/j;
    .locals 1

    invoke-super {p0}, Lcom/mg/ola/a/a/b/n;->j()Lcom/mg/ola/a/a/b/n;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/j;

    return-object v0
.end method

.method public synthetic j()Lcom/mg/ola/a/a/b/n;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/j;->i()Lcom/mg/ola/a/a/b/j;

    move-result-object v0

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ObjectAnimator@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Object;->hashCode()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ", target "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/j;->i:Ljava/lang/Object;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    array-length v2, v2

    if-ge v1, v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "\n    "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lcom/mg/ola/a/a/b/j;->f:[Lcom/mg/ola/a/a/b/l;

    aget-object v0, v0, v1

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/l;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-object v0
.end method
