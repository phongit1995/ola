.class public Lchat/ola/vn/util/h;
.super Ljava/lang/Object;


# static fields
.field private static a:Lchat/ola/vn/util/h;


# instance fields
.field private final b:Landroid/content/Context;

.field private final c:Ljava/util/regex/Pattern;

.field private final d:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/util/h;->b:Landroid/content/Context;

    invoke-direct {p0}, Lchat/ola/vn/util/h;->b()Ljava/util/HashMap;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/util/h;->d:Ljava/util/HashMap;

    invoke-direct {p0}, Lchat/ola/vn/util/h;->c()Ljava/util/regex/Pattern;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/util/h;->c:Ljava/util/regex/Pattern;

    return-void
.end method

.method public static a()Lchat/ola/vn/util/h;
    .locals 2

    sget-object v0, Lchat/ola/vn/util/h;->a:Lchat/ola/vn/util/h;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/util/h;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lchat/ola/vn/util/h;-><init>(Landroid/content/Context;)V

    sput-object v0, Lchat/ola/vn/util/h;->a:Lchat/ola/vn/util/h;

    :cond_0
    sget-object v0, Lchat/ola/vn/util/h;->a:Lchat/ola/vn/util/h;

    return-object v0
.end method

.method private b()Ljava/util/HashMap;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sget-object v1, Lchat/ola/vn/r/c;->a:[Lchat/ola/vn/entry/h;

    array-length v2, v1

    const/4 v3, 0x0

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v2, :cond_1

    aget-object v5, v1, v4

    iget-object v6, v5, Lchat/ola/vn/entry/h;->b:[Ljava/lang/String;

    array-length v7, v6

    const/4 v8, 0x0

    :goto_1
    if-ge v8, v7, :cond_0

    aget-object v9, v6, v8

    iget v10, v5, Lchat/ola/vn/entry/h;->d:I

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v0, v9, v10}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method private c()Ljava/util/regex/Pattern;
    .locals 4

    new-instance v0, Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/util/h;->d:Ljava/util/HashMap;

    invoke-virtual {v1}, Ljava/util/HashMap;->size()I

    move-result v1

    mul-int/lit8 v1, v1, 0x3

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance v1, Ljava/util/ArrayList;

    iget-object v2, p0, Lchat/ola/vn/util/h;->d:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    new-instance v2, Lchat/ola/vn/util/h$1;

    invoke-direct {v2, p0}, Lchat/ola/vn/util/h$1;-><init>(Lchat/ola/vn/util/h;)V

    invoke-static {v1, v2}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->isLetterOrDigit(C)Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v3, "\\b"

    goto :goto_1

    :cond_0
    const-string v3, "\\B"

    :goto_1
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/util/regex/Pattern;->quote(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v2, 0x7c

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v2

    const-string v3, ")"

    invoke-virtual {v0, v1, v2, v3}, Ljava/lang/StringBuilder;->replace(IILjava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public a(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;
    .locals 5

    if-nez p1, :cond_0

    const-string p1, ""

    return-object p1

    :cond_0
    instance-of v0, p1, Landroid/text/SpannableString;

    if-eqz v0, :cond_1

    move-object v0, p1

    check-cast v0, Landroid/text/SpannableString;

    goto :goto_0

    :cond_1
    new-instance v0, Landroid/text/SpannableString;

    invoke-direct {v0, p1}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    :goto_0
    iget-object v1, p0, Lchat/ola/vn/util/h;->c:Ljava/util/regex/Pattern;

    invoke-virtual {v1, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p1

    :catch_0
    :goto_1
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_2

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/util/h;->d:Ljava/util/HashMap;

    invoke-virtual {p1}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    new-instance v2, Landroid/text/style/ImageSpan;

    iget-object v3, p0, Lchat/ola/vn/util/h;->b:Landroid/content/Context;

    const/4 v4, 0x0

    invoke-direct {v2, v3, v1, v4}, Landroid/text/style/ImageSpan;-><init>(Landroid/content/Context;II)V

    invoke-virtual {p1}, Ljava/util/regex/Matcher;->start()I

    move-result v1

    invoke-virtual {p1}, Ljava/util/regex/Matcher;->end()I

    move-result v3

    const/16 v4, 0x21

    invoke-virtual {v0, v2, v1, v3, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_2
    return-object v0
.end method

.method public a(Ljava/lang/String;)Ljava/lang/Integer;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/h;->d:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Landroid/text/Editable;)V
    .locals 5

    if-eqz p1, :cond_2

    invoke-interface {p1}, Landroid/text/Editable;->length()I

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/util/h;->c:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-virtual {v0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/util/h;->d:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->start()I

    move-result v2

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->end()I

    move-result v3

    const-class v4, Landroid/text/style/ImageSpan;

    invoke-interface {p1, v2, v3, v4}, Landroid/text/Editable;->getSpans(IILjava/lang/Class;)[Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Landroid/text/style/ImageSpan;

    array-length v2, v2

    if-gtz v2, :cond_1

    new-instance v2, Landroid/text/style/ImageSpan;

    iget-object v3, p0, Lchat/ola/vn/util/h;->b:Landroid/content/Context;

    invoke-direct {v2, v3, v1}, Landroid/text/style/ImageSpan;-><init>(Landroid/content/Context;I)V

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->start()I

    move-result v1

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->end()I

    move-result v3

    const/16 v4, 0x21

    invoke-interface {p1, v2, v1, v3, v4}, Landroid/text/Editable;->setSpan(Ljava/lang/Object;III)V

    goto :goto_0

    :cond_2
    return-void
.end method
